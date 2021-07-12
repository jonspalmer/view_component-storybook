# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Controls
      class BooleanConfig < ControlConfig
        BOOLEAN_VALUES = [true, false].freeze

        validates :value, inclusion: { in: BOOLEAN_VALUES }, unless: -> { value.nil? }

        def type
          :boolean
        end

        def value_from_params(params)
          params_value = super(params)
          if params_value.is_a?(String) && params_value.present?
            case params_value
            when "true"
              true
            when "false"
              false
            end
          else
            params_value
          end
        end
      end
    end
  end
end
