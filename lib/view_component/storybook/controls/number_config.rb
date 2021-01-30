# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Controls
      class NumberConfig < ControlConfig
        attr_reader :type, :min, :max, :step

        validates :type, presence: true

        def initialize(type, component, param, value, min: nil, max: nil, step: nil, name: nil)
          super(component, param, value, name: name)
          @type = type
          @min = min
          @max = max
          @step = step
        end

        def value_from_param(param)
          if param.is_a?(String) && param.present?
            (param.to_f % 1) > 0 ? param.to_f : param.to_i
          else
            super(param)
          end
        end

        private

        def csf_control_params
          params = super
          params.merge(min: min, max: max, step: step).compact
        end
      end
    end
  end
end
