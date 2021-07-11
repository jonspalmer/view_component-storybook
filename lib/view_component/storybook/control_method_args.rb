# frozen_string_literal: true

module ViewComponent
  module Storybook
    class ControlMethodArgs
      attr_reader :target_method, :args, :kwargs, :block

      def initialize(target_method, *args, **kwargs, &block)
        @target_method = target_method
        @args = args
        @kwargs = kwargs
        @block = block
        assign_control_params
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
        args.concat(kwargs.values).select(&method(:control_config?))
      end

      private

      def assign_control_params
        kwargs.each do |key, val|
          val.param = key if control_config?(val) && val.param.nil?
        end
      end

      def value_from_params(arg, params)
        if control_config?(arg)
          value = arg.value_from_params(params)
          value = arg.value if value.nil? # nil only not falsey
          value
        else
          arg
        end
      end

      def control_config?(arg)
        arg.is_a?(ViewComponent::Storybook::Controls::ControlConfig)
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
