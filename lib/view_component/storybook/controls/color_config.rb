# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Controls
      class ColorConfig < SimpleControlConfig
        attr_reader :preset_colors

        def initialize(default_value, preset_colors: nil, param: nil, name: nil, description: nil)
          super(default_value, param: param, name: name, description: description)
          @preset_colors = preset_colors
        end

        def type
          :color
        end

        private

        def csf_control_params
          super.merge(presetColors: preset_colors).compact
        end
      end
    end
  end
end
