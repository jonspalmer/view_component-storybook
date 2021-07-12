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
            msg = "expected no more than #{target_method_params_names.max_arg_count} but found #{arg_count}"
            errors.add(:args, :invalid, value: arg_count, message: msg)
          elsif arg_count < target_method_params_names.min_arg_count
            msg = "expected at least #{target_method_params_names.min_arg_count} but found #{arg_count}"
            errors.add(:args, :invalid, value: arg_count, message: msg)
          end
        end

        def validate_kwargs
          kwargs.each_key do |kwarg|
            unless target_method_params_names.include_kwarg?(kwarg)
              errors.add(:kwargs, :invalid, value: kwarg, message: "'#{kwarg}' is invalid")
            end
          end

          return if target_method_params_names.covers_required_kwargs?(kwargs.keys)

          msg = "expected keys [#{target_method_params_names.req_kwarg_names.join(', ')}] but found [#{kwargs.keys.join(', ')}]"
          errors.add(:kwargs, :invalid, value: kwargs.keys, message: msg)
        end
      end
    end
  end
end
