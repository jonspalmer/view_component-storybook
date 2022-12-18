# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Controls
      class Date < SimpleControl
        def type
          :date
        end

        def parse_param_value(value)
          if value.is_a?(String)
            DateTime.iso8601(value)
          else
            value
          end
        end

        private

        def csf_value
          case default
          when ::Date
            default.in_time_zone
          when Time
            default.iso8601
          end
        end
      end
    end
  end
end
