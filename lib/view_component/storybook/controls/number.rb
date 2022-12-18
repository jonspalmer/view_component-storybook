# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Controls
      class Number < SimpleControl
        TYPES = %i[number range].freeze

        attr_reader :type, :min, :max, :step

        validates :type, presence: true
        validates :type, inclusion: { in: TYPES }, unless: -> { type.nil? }

        def initialize(param, type:, default: nil, min: nil, max: nil, step: nil, name: nil, description: nil, **opts)
          super(param, default: default, name: name, description: description, **opts)
          @type = type
          @min = min
          @max = max
          @step = step
        end

        def parse_param_value(value)
          if value.is_a?(String) && value.present?
            (value.to_f % 1) > 0 ? value.to_f : value.to_i
          else
            value
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
