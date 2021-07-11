# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Controls
      class ColorConfig < ControlConfig
        attr_reader :preset_colors

        def initialize(value, param: nil, name: nil, preset_colors: nil)
          super(value, param: param, name: name)
          @preset_colors = preset_colors
        end

        def type
          :color
        end

        private

        def csf_control_params
          params = super
          params.merge(presetColors: preset_colors).compact
        end
      end
    end
  end
end
