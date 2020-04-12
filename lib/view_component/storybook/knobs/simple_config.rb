# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Knobs
      class SimpleConfig < KnobConfig
        TYPES = %i[text boolean color].freeze
        BOOLEAN_VALUES = [true, false].freeze

        attr_reader :type

        validates :value, presence: true, unless: -> { type == :boolean }
        validates :value, inclusion: { in: BOOLEAN_VALUES }, if: -> { type == :boolean }

        validates :type, presence: true
        validates :type, inclusion: { in: TYPES }, unless: -> { type.nil? }

        def initialize(type, component, param, value, name: nil, group_id: nil)
          super(component, param, value, name: name, group_id: group_id)
          @type = type
        end

        def value_from_param(param)
          if type == :boolean && param.is_a?(String) && param.present?
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
