# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Controls
      class Object < SimpleControl
        def type
          :object
        end

        def parse_param_value(value)
          if value.is_a?(String)
            parsed_json = JSON.parse(value)
            if parsed_json.is_a?(Array)
              parsed_json.map do |item|
                item.is_a?(Hash) ? item.deep_symbolize_keys : item
              end
            else
              parsed_json.deep_symbolize_keys
            end
          else
            value
          end
        end
      end
    end
  end
end
