# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Knobs
      class DateConfig < KnobConfig
        validates :value, presence: true

        def initialize(component, param, value, name: nil, group_id: nil)
          super(component, param, value, name: name, group_id: group_id)
        end

        def to_csf_params
          csf_params = super
          params_value = value
          params_value = params_value.in_time_zone if params_value.is_a?(Date)
          params_value = params_value.iso8601 if params_value.is_a?(Time)
          csf_params[:value] = params_value
          csf_params
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
      end
    end
  end
end
