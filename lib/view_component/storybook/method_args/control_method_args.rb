# frozen_string_literal: true

module ViewComponent
  module Storybook
    module MethodArgs
      ##
      # Class representing arguments passed to a method which can be validated
      # against the args of the target method
      # I addition the args and kwargs can contain Controls the values of which can
      # be resolved from a params hash
      class ControlMethodArgs < ValidatableMethodArgs
        include ActiveModel::Validations

        def initialize(target_method, *args, **kwargs, &block)
          super(target_method, *args, **kwargs, &block)
          assign_control_params
        end

        def resolve_method_args(params)
          args_from_params = args.map do |arg|
            value_from_params(arg, params)
          end
          kwargs_from_params = kwargs.transform_values do |arg|
            value_from_params(arg, params)
          end

          MethodArgs.new(args_from_params, kwargs_from_params, block)
        end

        def controls
          args.concat(kwargs.values).select(&method(:control?))
        end

        private

        def assign_control_params
          args.each_with_index do |arg, index|
            arg.param = target_method_params_names.arg_name(index) if control?(arg) && arg.param.nil?
          end

          kwargs.each do |key, arg|
            arg.param = key if control?(arg) && arg.param.nil?
          end
        end

        def value_from_params(arg, params)
          if control?(arg)
            value = arg.value_from_params(params)
            value = arg.value if value.nil? # nil only not falsey
            value
          else
            arg
          end
        end

        def control?(arg)
          arg.is_a?(ViewComponent::Storybook::Controls::ControlConfig)
        end
      end
    end
  end
end
