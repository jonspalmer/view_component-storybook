# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Dsl
      module ControlsDsl
        def text(value, param: nil, name: nil)
          Controls::TextConfig.new(value, param: param, name: name)
        end

        def boolean(value, param: nil, name: nil)
          Controls::BooleanConfig.new(value, param: param, name: name)
        end

        def number(value, param: nil, name: nil, min: nil, max: nil, step: nil)
          Controls::NumberConfig.new(:number, value, param: param, name: name, min: min, max: max, step: step)
        end

        def range(value, param: nil, name: nil, min: nil, max: nil, step: nil)
          Controls::NumberConfig.new(:range, value, param: param, name: name, min: min, max: max, step: step)
        end

        def color(value, param: nil, name: nil, preset_colors: nil)
          Controls::ColorConfig.new(value, param: param, name: name, preset_colors: preset_colors)
        end

        def object(value, param: nil, name: nil)
          Controls::ObjectConfig.new(value, param: param, name: name)
        end

        def select(options, value, param: nil, name: nil)
          Controls::OptionsConfig.new(:select, options, value, param: param, name: name)
        end

        def multi_select(options, value, param: nil, name: nil)
          Controls::OptionsConfig.new(:'multi-select', options, value, param: param, name: name)
        end

        def radio(options, value, param: nil, name: nil)
          Controls::OptionsConfig.new(:radio, options, value, param: param, name: name)
        end

        def inline_radio(options, value, param: nil, name: nil)
          Controls::OptionsConfig.new(:'inline-radio', options, value, param: param, name: name)
        end

        def check(options, value, param: nil, name: nil)
          Controls::OptionsConfig.new(:check, options, value, param: param, name: name)
        end

        def inline_check(options, value, param: nil, name: nil)
          Controls::OptionsConfig.new(:'inline-check', options, value, param: param, name: name)
        end

        def array(value, separator = ",", param: nil, name: nil)
          Controls::ArrayConfig.new(value, separator, param: param, name: name)
        end

        def date(value, param: nil, name: nil)
          Controls::DateConfig.new(value, param: param, name: name)
        end

        Controls = ViewComponent::Storybook::Controls
      end
    end
  end
end
