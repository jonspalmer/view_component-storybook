# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Controls
      class TextConfig < ControlConfig
        validates :value, presence: true

        def type
          :text
        end
      end
    end
  end
end
