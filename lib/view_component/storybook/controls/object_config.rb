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
            JSON.parse(param).symbolize_keys
          else
            super(param)
          end
        end
      end
    end
  end
end
