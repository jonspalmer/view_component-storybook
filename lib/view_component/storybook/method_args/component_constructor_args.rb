# frozen_string_literal: true

module ViewComponent
  module Storybook
    module MethodArgs
      ##
      # Class representing the constructor args for a Component
      class ComponentConstructorArgs < ControlMethodArgs
        def self.from_component_class(component_class, *args, **kwargs)
          if DryInitializerComponentConstructorArgs.dry_initialize?(component_class)
            DryInitializerComponentConstructorArgs.new(component_class, *args, **kwargs)
          else
            new(component_class, *args, **kwargs)
          end
        end

        def initialize(component_class, *args, **kwargs)
          super(component_class.instance_method(:initialize), *args, **kwargs)
        end
      end
    end
  end
end
