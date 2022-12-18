# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Controls
      ##
      # A simple Control Config maps to one Storybook Control
      # It has a value and pulls its value from params by key
      class SimpleControlConfig < ControlConfig
        def initialize(param, default: nil, name: nil, description: nil, **opts)
          super(param, default: default, name: name, description: description, **opts)
        end

        def to_csf_params
          validate!
          {
            args: { param => csf_value },
            argTypes: {
              param => { control: csf_control_params, name: name, description: description }.compact
            }
          }
        end

        def value_from_params(params)
          params.key?(param) ? params[param] : default
        end

        private

        # provide extension points for subclasses to vary the value
        def type
          # :nocov:
          raise NotImplementedError
          # :nocov:
        end

        def csf_value
          default
        end

        def csf_control_params
          { type: type }
        end
      end
    end
  end
end
