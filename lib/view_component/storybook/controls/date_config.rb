# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Controls
      class DateConfig < SimpleControlConfig
        def initialize(default_value, param: nil, name: nil, description: nil)
          super(default_value, param: param, name: name, description: description)
        end

        def type
          :date
        end

        def value_from_params(params)
          params_value = super(params)
          if params_value.is_a?(String)
            DateTime.iso8601(params_value)
          else
            params_value
          end
        end

        private

        def csf_value
          case default_value
          when Date
            default_value.in_time_zone
          when Time
            default_value.iso8601
          end
        end
      end
    end
  end
end
