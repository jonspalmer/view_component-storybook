# frozen_string_literal: true

module ViewComponent
  module Storybook
    module MethodArgs
      ##
      # Class representing arguments passed to a method which can be validated
      # against the args of the target method
      class ValidatableMethodArgs < MethodArgs
        include ActiveModel::Validations

        attr_reader :target_method_params_names

        validate :validate_args, :validate_kwargs

        def initialize(target_method, *args, **kwargs, &block)
          @target_method_params_names = MethodParametersNames.new(target_method)
          super(args, kwargs, block)
        end

        private

        def validate_args
          arg_count = args.count

          if arg_count > target_method_params_names.max_arg_count
            errors.add(:args, :too_many, max: target_method_params_names.max_arg_count, count: arg_count)
          elsif arg_count < target_method_params_names.min_arg_count
            errors.add(:args, :too_few, min: target_method_params_names.min_arg_count, count: arg_count)
          end
        end

        def validate_kwargs
          kwargs.each_key do |kwarg|
            unless target_method_params_names.include_kwarg?(kwarg)
              errors.add(:kwargs, :invalid_arg, kwarg: kwarg)
            end
          end

          return if target_method_params_names.covers_required_kwargs?(kwargs.keys)

          expected_keys = target_method_params_names.req_kwarg_names.join(', ')
          actual_keys = kwargs.keys.join(', ')

          errors.add(:kwargs, :invalid, expected_keys: expected_keys, actual_keys: actual_keys)
        end
      end
    end
  end
end
