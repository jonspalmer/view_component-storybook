# frozen_string_literal: true

module ViewComponent
  module Storybook
    class StoryConfig
      include ActiveModel::Validations

      attr_reader :id, :name, :component
      attr_accessor :parameters, :layout, :content_block

      validate :validate_constructor_args

      def initialize(id, name, component, layout)
        @id = id
        @name = name
        @component = component
        @layout = layout
      end

      def constructor_args(*args, **kwargs, &block)
        if args.empty? && kwargs.empty? && block.nil?
          @constructor_args ||= ViewComponent::Storybook::MethodArgs::ControlMethodArgs.new(component_constructor)
        else
          @constructor_args = ViewComponent::Storybook::MethodArgs::ControlMethodArgs.new(
            component_constructor,
            *args,
            **kwargs,
            &block
          )
        end
      end

      def to_csf_params
        validate!
        csf_params = { name: name, parameters: { server: { id: id } } }
        csf_params.deep_merge!(parameters: parameters) if parameters.present?
        constructor_args.controls.each do |control|
          csf_params.deep_merge!(control.to_csf_params)
        end
        csf_params
      end

      def validate!
        valid? || raise(ValidationError, self)
      end

      def self.configure(id, name, component, layout, &configuration)
        config = new(id, name, component, layout)
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
        component.instance_method(:initialize)
      end
    end
  end
end
