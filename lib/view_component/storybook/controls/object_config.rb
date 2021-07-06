# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Controls
      class ObjectConfig < ControlConfig
        def type
          :object
        end

        def value_from_param(param)
          if param.is_a?(String)
            parsed_json = JSON.parse(param)
            if parsed_json.is_a?(Array)
              parsed_json.map(&:deep_symbolize_keys)
            else
              parsed_json.deep_symbolize_keys
            end
          else
            super(param)
          end
        end
      end
    end
  end
end
