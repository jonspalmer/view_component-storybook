# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Controls
      class CustomConfig < ControlConfig
        attr_reader :value_method_args

        validate :validate_value_method_args

        def with_value(*args, **kwargs, &block)
          @value_method_args = MethodArgs::ControlMethodArgs.new(block, *args, **kwargs)
          @value_method_args.with_param_prefix(param)
          self
        end

        def param(new_param = nil)
          value_method_args.with_param_prefix(new_param) unless new_param.nil?
          super(new_param)
        end

        def to_csf_params
          validate!
          # TODO: Figure out if we can use 'category' with the args table
          # export default {
          #   argTypes: {
          #     foo: {
          #       table: { category: 'cat', subcategory: 'sub' }
          #     }
          #   }
          # }
          value_method_args.controls.reduce({}) do |csf_params, control|
            csf_params.deep_merge(control.to_csf_params)
          end
        end

        def value_from_params(params)
          value_method_args.call(params)
        end

        private

        def validate_value_method_args
          return if value_method_args.valid?

          value_method_args_errors = value_method_args.errors.full_messages.join(', ')
          errors.add(:value_method_args, :invalid, errors: value_method_args_errors)
        end
      end
    end
  end
end
