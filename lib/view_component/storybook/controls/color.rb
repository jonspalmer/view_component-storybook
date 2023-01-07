# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Controls
      class Color < SimpleControl
        attr_reader :preset_colors

        def initialize(param, default: nil, preset_colors: nil, name: nil, description: nil, **opts)
          super(param, default: default, name: name, description: description, **opts)
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
