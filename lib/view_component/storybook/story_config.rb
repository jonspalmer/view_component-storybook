# frozen_string_literal: true

module ViewComponent
  module Storybook
    class StoryConfig
      include ActiveModel::Validations

      attr_reader :id, :name, :component_class, :content_control, :content_block
      attr_accessor :parameters, :layout

      validate :validate_constructor_args

      def initialize(id, name, component_class, layout)
        @id = id
        @name = name
        @component_class = component_class
        @layout = layout
      end

      def constructor_args(*args, **kwargs)
        if args.empty? && kwargs.empty?
          @constructor_args ||= ViewComponent::Storybook::MethodArgs::ControlMethodArgs.new(component_constructor)
        else
          @constructor_args = ViewComponent::Storybook::MethodArgs::ControlMethodArgs.new(
            component_constructor,
            *args,
            **kwargs
          )
        end
      end

      def with_content(content = nil, &block)
        case content
        when Storybook::Controls::ControlConfig
          @content_control = content.param(:content)
          @content_block = nil
        when String
          @content_control = nil
          @content_block = proc { content }
        else
          @content_control = nil
          @content_block = block
        end
      end

      def to_csf_params
        validate!
        csf_params = { name: name, parameters: { server: { id: id } } }
        csf_params.deep_merge!(parameters: parameters) if parameters.present?
        controls = constructor_args.controls
        controls << content_control if content_control
        controls.each do |control|
          csf_params.deep_merge!(control.to_csf_params)
        end
        csf_params
      end

      def validate!
        valid? || raise(ValidationError, self)
      end

      def story(params)
        # constructor_args.target_method is UnboundMethod so can't call it directly
        component = constructor_args.call(params) do |*args, **kwargs|
          component_class.new(*args, **kwargs)
        end

        if content_control
          content = content_control.value_from_params(params) if content_control
          story_content_block = proc { content }
        else
          story_content_block = content_block
        end

        Storybook::Story.new(component, story_content_block, layout)
      end

      def self.configure(id, name, component_class, layout, &configuration)
        config = new(id, name, component_class, layout)
        ViewComponent::Storybook::Dsl::StoryDsl.evaluate!(config, &configuration)
        config
      end

      def validate_constructor_args
        return if constructor_args.valid?

        constructor_args_errors = constructor_args.errors.full_messages.join(', ')
        errors.add(:constructor_args, :invalid, errors: constructor_args_errors)
      end

      class ValidationError < StandardError
        attr_reader :story_config

        def initialize(story_config)
          @story_config = story_config

          super("'#{@story_config.name}' invalid: (#{@story_config.errors.full_messages.join(', ')})")
        end
      end

      private

      def component_constructor
        component_class.instance_method(:initialize)
      end
    end
  end
end
