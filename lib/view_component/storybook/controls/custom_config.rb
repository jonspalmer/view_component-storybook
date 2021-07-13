# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Controls
      class CustomConfig < ControlConfig
        attr_reader :value_method_args

        # TODO: Add to Errors with custom messages
        validate { value_method_args.valid? }

        def with_value(*args, **kwargs, &block)
          @value_method_args = ViewComponent::Storybook::MethodArgs::ControlMethodArgs.new(block, *args, **kwargs, &block)
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
          method_args = value_method_args.resolve_method_args(params)

          method_args.block.call(*method_args.args, **method_args.kwargs)
        end
      end
    end
  end
end
