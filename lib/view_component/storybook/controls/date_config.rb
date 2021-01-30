# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Controls
      class DateConfig < ControlConfig
        def initialize(component, param, value, name: nil)
          super(component, param, value, name: name)
        end

        def type
          :date
        end

        def value_from_param(param)
          if param.is_a?(String)
            DateTime.iso8601(param)
          else
            super(param)
          end
        end

        private

        def csf_value
          params_value = value
          params_value = params_value.in_time_zone if params_value.is_a?(Date)
          params_value = params_value.iso8601 if params_value.is_a?(Time)
          params_value
        end
      end
    end
  end
end
