# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Controls
      ##
      # A simple Control Config maps to one Storybook Control
      # It has a value and pulls its value from params by key
      class SimpleControlConfig < ControlConfig
        attr_reader :default_value

        def initialize(default_value, param: nil, name: nil)
          super(param: param, name: name)
          @default_value = default_value
        end

        def to_csf_params
          validate!
          {
            args: { param => csf_value },
            argTypes: { param => { control: csf_control_params, name: name } }
          }
        end

        def value_from_params(params)
          params[param]
        end

        private

        # provide extension points for subclasses to vary the value
        def type
          # :nocov:
          raise NotImplementedError
          # :nocov:
        end

        def csf_value
          default_value
        end

        def csf_control_params
          { type: type }
        end
      end
    end
  end
end
