# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Controls
      class BooleanConfig < ControlConfig
        BOOLEAN_VALUES = [true, false].freeze

        validates :value, inclusion: { in: BOOLEAN_VALUES }

        def type
          :boolean
        end

        def value_from_param(param)
          if param.is_a?(String) && param.present?
            case param
            when "true"
              true
            when "false"
              false
            end
          else
            super(param)
          end
        end
      end
    end
  end
end
