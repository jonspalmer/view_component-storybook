# frozen_string_literal: true

module ViewComponent
  module Storybook
    class StoryConfig
      include ActiveModel::Validations
      include WithContent
      include Controls::ControlsHelpers

      attr_reader :id, :name, :component_class

      validate :validate_constructor_args

      def initialize(id, name, component_class, layout)
        @id = id
        @name = name
        @component_class = component_class
        @layout = layout
        @slots ||= {}
      end

      def constructor(*args, **kwargs, &block)
        @constructor_args = MethodArgs::ControlMethodArgs.new(
          component_constructor,
          *args,
          **kwargs
        )
        with_content(nil, &block)

        self
      end

      # Once deprecated block version is removed make this a private getter
      def controls(&block)
        if block_given?
          ActiveSupport::Deprecation.warn("`controls` will be removed in v1.0.0. Use `#constructor` instead.")
          controls_dsl = Dsl::LegacyControlsDsl.new
          controls_dsl.instance_eval(&block)

          controls_hash = controls_dsl.controls.index_by(&:param)
          constructor(**controls_hash)
        else
          list = constructor_args.controls.dup
          list << content_control if content_control
          list += slots.flat_map(&:controls) if slots
          list
        end
      end

      def layout(layout = nil)
        @layout = layout unless layout.nil?
        @layout
      end

      def parameters(parameters = nil)
        @parameters = parameters unless parameters.nil?
        @parameters
      end

      def slot(slot_name, *args, **kwargs, &block)
        # if the name is a slot then build a SlotConfig with slot_name and param the same
        if component_class.registered_slots[slot_name]
          slot_config = Slots::SlotConfig.from_component(
            component_class,
            slot_name,
            slot_name,
            *args,
            **kwargs,
            &block
          )
          @slots[slot_name] = slot_config
        else
          # if the slot_name isn't registered them we're looking for a renders_many slot
          # we need a unique param generated by the count of slots with this name already added
          @slots[slot_name] ||= []
          slot_index = @slots[slot_name].count + 1
          slot_config = Slots::SlotConfig.from_component(
            component_class,
            slot_name,
            "#{slot_name}#{slot_index}".to_sym,
            *args,
            **kwargs,
            &block
          )
          @slots[slot_name] << slot_config
        end
        slot_config
      end

      def to_csf_params
        validate!
        csf_params = { name: name, parameters: { server: { id: id } } }
        csf_params.deep_merge!(parameters: parameters) if parameters.present?
        controls.each do |control|
          csf_params.deep_merge!(control.to_csf_params)
        end
        csf_params
      end

      def validate!
        valid? || raise(ValidationError, self)
      end

      ##
      # Build a Story from this config
      # * Resolves the values of the constructor args from the params
      # * constructs the component
      # * resolve the content_control and content_block to a single block
      # * builds a list of Slots by resolving their args from the params
      def story(params)
        # constructor_args.target_method is UnboundMethod so can't call it directly
        component = constructor_args.call(params) do |*args, **kwargs|
          component_class.new(*args, **kwargs)
        end

        story_content_block = resolve_content_block(params)

        story_slots = slots.map do |slot_config|
          slot_config.slot(component, params)
        end

        Storybook::Story.new(component, story_content_block, story_slots, layout)
      end

      class ValidationError < StandardError
        attr_reader :story_config

        def initialize(story_config)
          @story_config = story_config

          super("'#{@story_config.name}' invalid: (#{@story_config.errors.full_messages.join(', ')})")
        end
      end

      private

      def constructor_args
        @constructor_args ||= MethodArgs::ControlMethodArgs.new(component_constructor)
      end

      def component_constructor
        component_class.instance_method(:initialize)
      end

      def slots
        @slots.values.flatten
      end

      def validate_constructor_args
        return if constructor_args.valid?

        constructor_args_errors = constructor_args.errors.full_messages.join(', ')
        errors.add(:constructor_args, :invalid, errors: constructor_args_errors)
      end
    end
  end
end
