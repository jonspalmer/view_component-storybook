# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Knobs
      class ObjectConfig < KnobConfig
        validates :value, presence: true

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
