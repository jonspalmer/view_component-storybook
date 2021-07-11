# frozen_string_literal: true

module ViewComponent
  module Storybook
    class ControlMethodArgs
      attr_reader :args, :kwargs, :block

      def initialize(*args, **kwargs, &block)
        @args = args
        @kwargs = kwargs
        @block = block
      end

      def method_args(params)
        args_from_params = args.map do |arg|
          value_from_params(arg, params)
        end
        kwargs_from_params = kwargs.transform_values do |arg|
          value_from_params(arg, params)
        end

        MethodArgs.new(args_from_params, kwargs_from_params, block)
      end

      def controls
        args.concat(kwargs.values).select{ |arg| arg.is_a?(ViewComponent::Storybook::Controls::ControlConfig) }
      end

      private

      def value_from_params(arg, params)
        if arg.is_a?(ViewComponent::Storybook::Controls::ControlConfig)
          value = arg.value_from_params(params)
          value = arg.value if value.nil? # nil only not falsey
          value
        else
          arg
        end
      end

      class MethodArgs
        attr_reader :args, :kwargs, :block

        def initialize(args, kwargs, block)
          @args = args
          @kwargs = kwargs
          @block = block
        end
      end
    end
  end
end
