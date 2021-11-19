# frozen_string_literal: true

module ViewComponent
  module Storybook
    module MethodArgs
      ##
      # Class representing arguments passed to a method which can be validated
      # against the args of the target method
      # In addition the args and kwargs can contain Controls the values of which can
      # be resolved from a params hash
      class ControlMethodArgs < MethodArgs
        include ActiveModel::Validations::Callbacks

        attr_reader :param_prefix

        validate :validate_controls
        before_validation :assign_control_params

        def with_param_prefix(prefix)
          @param_prefix = prefix
          self
        end

        ##
        # resolve the controls values from the params
        # call the target method or block with those values
        def call(params, &target_block)
          method_args = resolve_method_args(params)

          (target_block || target_method).call(*method_args.args, **method_args.kwargs)
        end

        def resolve_method_args(params)
          assign_control_params

          args_from_params = args.map do |arg|
            value_from_params(arg, params)
          end
          kwargs_from_params = kwargs.transform_values do |arg|
            value_from_params(arg, params)
          end

          MethodArgs.new(target_method, *args_from_params, **kwargs_from_params)
        end

        def controls
          @controls ||= (args + kwargs.values).select(&method(:control?))
        end

        def assign_control_params
          return if @assigned_control_params

          args.each_with_index do |arg, index|
            add_param_if_control(arg, target_method_params_names.arg_name(index))
          end

          kwargs.each do |key, arg|
            add_param_if_control(arg, key)
          end

          @assigned_control_params = true
        end

        private

        def add_param_if_control(arg, param)
          return unless control?(arg)

          arg.param(param) if arg.param.nil? # don't overrite if set
          # Always add prefix
          arg.prefix_param(param_prefix) if param_prefix.present?
        end

        def value_from_params(arg, params)
          control?(arg) ? arg.value_from_params(params) : arg
        end

        def control?(arg)
          arg.is_a?(Controls::ControlConfig)
        end

        def validate_controls
          controls.reject(&:valid?).each do |control|
            control_errors = control.errors.full_messages.join(', ')
            errors.add(:controls, :invalid_control, control_name: control.name, control_errors: control_errors)
          end
        end
      end
    end
  end
end
