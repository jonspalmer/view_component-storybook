# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Dsl
      module ControlsDsl
        def text(param, value, name: nil)
          Controls::TextConfig.new(component, param, value, name: name)
        end

        def boolean(param, value, name: nil)
          Controls::BooleanConfig.new(component, param, value, name: name)
        end

        def number(param, value, name: nil, min: nil, max: nil, step: nil)
          Controls::NumberConfig.new(:number, component, param, value, name: name, min: min, max: max, step: step)
        end

        def range(param, value, name: nil, min: nil, max: nil, step: nil)
          Controls::NumberConfig.new(:range, component, param, value, name: name, min: min, max: max, step: step)
        end

        def color(param, value, name: nil, preset_colors: nil)
          Controls::ColorConfig.new(component, param, value, name: name, preset_colors: preset_colors)
        end

        def object(param, value, name: nil)
          Controls::ObjectConfig.new(component, param, value, name: name)
        end

        def select(param, options, value, name: nil)
          Controls::OptionsConfig.new(:select, component, param, options, value, name: name)
        end

        def multi_select(param, options, value, name: nil)
          Controls::OptionsConfig.new(:'multi-select', component, param, options, value, name: name)
        end

        def radio(param, options, value, name: nil)
          Controls::OptionsConfig.new(:radio, component, param, options, value, name: name)
        end

        def inline_radio(param, options, value, name: nil)
          Controls::OptionsConfig.new(:'inline-radio', component, param, options, value, name: name)
        end

        def check(param, options, value, name: nil)
          Controls::OptionsConfig.new(:check, component, param, options, value, name: name)
        end

        def inline_check(param, options, value, name: nil)
          Controls::OptionsConfig.new(:'inline-check', component, param, options, value, name: name)
        end

        def array(param, value, separator = ",", name: nil)
          Controls::ArrayConfig.new(component, param, value, separator, name: name)
        end

        def date(param, value, name: nil)
          Controls::DateConfig.new(component, param, value, name: name)
        end

        Controls = ViewComponent::Storybook::Controls
      end
    end
  end
end
