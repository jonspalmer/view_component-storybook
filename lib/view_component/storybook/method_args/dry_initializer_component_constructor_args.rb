# frozen_string_literal: true

module ViewComponent
  module Storybook
    module MethodArgs
      ##
      # Class representing the constructor args for a Component the extends dry-initializer
      class DryInitializerComponentConstructorArgs < ControlMethodArgs
        INITIALIZE_METHOD = :__dry_initializer_initialize__

        ##
        # Method Parameters names that are dry-initialize aware
        # THe main difference is that Dry Initializer keyword args cannot be deduced from the constructor initialize params
        # Instead we have to introspect the dry_initializer config for the option definitions
        class DryConstructorParametersNames < MethodParametersNames
          attr_reader :dry_initializer

          def initialize(component_class)
            super(component_class.instance_method(INITIALIZE_METHOD))
            @dry_initializer = component_class.dry_initializer
          end

          # Required keywords are the only thing we need.
          # We could define kwarg_names similarly but wihout the `optional` check. However, dry-initializer
          # always ends has supports_keyrest? == true so kwarg_names isn't needed
          def req_kwarg_names
            @req_kwarg_names ||= dry_initializer.definitions.map do |name, definition|
              name if definition.option && !definition.optional
            end.compact
          end
        end

        def self.dry_initialize?(component_class)
          component_class.private_method_defined?(INITIALIZE_METHOD)
        end

        def initialize(component_class, *args, **kwargs)
          super(component_class.instance_method(INITIALIZE_METHOD), *args, **kwargs)

          @target_method_params_names = DryConstructorParametersNames.new(component_class)
        end
      end
    end
  end
end
