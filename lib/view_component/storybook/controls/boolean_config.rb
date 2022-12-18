# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Controls
      class BooleanConfig < SimpleControlConfig
        BOOLEAN_VALUES = [true, false].freeze

        validates :default, inclusion: { in: BOOLEAN_VALUES }, unless: -> { default.nil? }

        def type
          :boolean
        end

        def parse_param_value(value)
          if value.is_a?(String) && value.present?
            case value
            when "true"
              true
            when "false"
              false
            end
          else
            value
          end
        end
      end
    end
  end
end
