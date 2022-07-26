# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Controls
      class NumberConfig < SimpleControlConfig
        TYPES = %i[number range].freeze

        attr_reader :type, :min, :max, :step

        validates :type, presence: true
        validates :type, inclusion: { in: TYPES }, unless: -> { type.nil? }

        def initialize(type, default_value, min: nil, max: nil, step: nil, param: nil, name: nil, description: nil)
          super(default_value, param: param, name: name, description: description)
          @type = type
          @min = min
          @max = max
          @step = step
        end

        def value_from_params(params)
          params_value = super(params)
          if params_value.is_a?(String) && params_value.present?
            (params_value.to_f % 1) > 0 ? params_value.to_f : params_value.to_i
          else
            params_value
          end
        end

        private

        def csf_control_params
          super.merge(min: min, max: max, step: step).compact
        end
      end
    end
  end
end
