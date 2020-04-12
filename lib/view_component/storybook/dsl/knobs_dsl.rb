# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Dsl
      class KnobsDsl
        attr_reader :component, :knobs

        def initialize(component)
          @component = component
          @knobs = []
        end

        def text(param, value, group_id: nil, name: nil)
          knobs << Knobs::SimpleConfig.new(:text, component, param, value, group_id: group_id, name: name)
        end

        def boolean(param, value, group_id: nil, name: nil)
          knobs << Knobs::SimpleConfig.new(:boolean, component, param, value, group_id: group_id, name: name)
        end

        def number(param, value, options = {}, group_id: nil, name: nil)
          knobs << Knobs::NumberConfig.new(component, param, value, options, group_id: group_id, name: name)
        end

        def color(param, value, group_id: nil, name: nil)
          knobs << Knobs::SimpleConfig.new(:color, component, param, value, group_id: group_id, name: name)
        end

        def object(param, value, group_id: nil, name: nil)
          knobs << Knobs::ObjectConfig.new(component, param, value, group_id: group_id, name: name)
        end

        def select(param, options, value, group_id: nil, name: nil)
          knobs << Knobs::OptionsConfig.new(:select, component, param, options, value, group_id: group_id, name: name)
        end

        def radios(param, options, value, group_id: nil, name: nil)
          knobs << Knobs::OptionsConfig.new(:radios, component, param, options, value, group_id: group_id, name: name)
        end

        def array(param, value, separator = ",", group_id: nil, name: nil)
          knobs << Knobs::ArrayConfig.new(component, param, value, separator, group_id: group_id, name: name)
        end

        def date(param, value, group_id: nil, name: nil)
          knobs << Knobs::DateConfig.new(component, param, value, group_id: group_id, name: name)
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

        Knobs = ViewComponent::Storybook::Knobs
      end
    end
  end
end
