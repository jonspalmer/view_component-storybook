# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Knobs
      class ArrayConfig < KnobConfig
        attr_reader :separator

        validates :value, :separator, presence: true

        def initialize(component, param, value, separator = ",", name: nil, group_id: nil)
          super(component, param, value, name: name, group_id: group_id)
          @separator = separator
        end

        def to_csf_params
          super.merge(value: value, separator: separator)
        end

        def type
          :array
        end

        def value_from_param(param)
          if param.is_a?(String)
            param.split(separator)
          else
            super(param)
          end
        end
      end
    end
  end
end
