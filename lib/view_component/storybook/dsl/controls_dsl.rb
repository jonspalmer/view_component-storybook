# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Dsl
      class ControlsDsl
        attr_reader :component, :controls

        def initialize(component)
          @component = component
          @controls = []
        end

        def text(param, value, name: nil)
          controls << Controls::SimpleConfig.new(:text, component, param, value, name: name)
        end

        def boolean(param, value, name: nil)
          controls << Controls::SimpleConfig.new(:boolean, component, param, value, name: name)
        end

        def number(param, value, options = {}, name: nil)
          controls << Controls::NumberConfig.new(component, param, value, options, name: name)
        end

        def color(param, value, name: nil)
          controls << Controls::SimpleConfig.new(:color, component, param, value, name: name)
        end

        def object(param, value, name: nil)
          controls << Controls::ObjectConfig.new(component, param, value, name: name)
        end

        def select(param, options, value, name: nil)
          controls << Controls::OptionsConfig.new(:select, component, param, options, value, name: name)
        end

        def radios(param, options, value, name: nil)
          controls << Controls::OptionsConfig.new(:radios, component, param, options, value, name: name)
        end

        def array(param, value, separator = ",", name: nil)
          controls << Controls::ArrayConfig.new(component, param, value, separator, name: name)
        end

        def date(param, value, name: nil)
          controls << Controls::DateConfig.new(component, param, value, name: name)
        end

        def respond_to_missing?(_method)
          true
        end

        def method_missing(method, *args)
          value = args.first
          knob_method = case value
                        when Date
                          :date
                        when Array
                          :array
                        when Hash
                          :object
                        when Numeric
                          :number
                        when TrueClass, FalseClass
                          :boolean
                        when String
                          :text
                        end
          if knob_method
            send(knob_method, method, *args)
          else
            super
          end
        end

        Controls = ViewComponent::Storybook::Controls
      end
    end
  end
end
