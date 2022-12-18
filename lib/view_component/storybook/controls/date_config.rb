# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Controls
      class DateConfig < SimpleControlConfig
        # def initialize(param, default: nil , name: nil, description: nil, **opts)
        #   super(param, default: default, name: name, description: description, **opts)
        # end

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
          when Date
            default.in_time_zone
          when Time
            default.iso8601
          end
        end
      end
    end
  end
end
