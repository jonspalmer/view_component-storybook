# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Controls
      module ControlsHelpers
        extend ActiveSupport::Concern

        included do
          class_attribute :controls
        end

        def inherited(other)
          super(other)
          # setup class defaults
          other.controls = []
        end

        class_methods do
          def inherited(other)
            super(other)
            # setup class defaults
            other.controls = []
          end

          def control(param, as:, default:, name: nil, description: nil, **opts)
            controls << case as
                        when :text
                          Controls::TextConfig.new(default, param: param, name: name, description: description, **opts)
                        when :boolean
                          Controls::BooleanConfig.new(default, param: param, name: name, description: description, **opts)
                        when :number
                          Controls::NumberConfig.new(:number, default, param: param, name: name, description: description, **opts)
                        when :range
                          Controls::NumberConfig.new(:range, default, param: param, name: name, description: description, **opts)
                        when :color
                          Controls::ColorConfig.new(default, param: param, name: name, description: description, **opts)
                        when :object, :array
                          Controls::ObjectConfig.new(default, param: param, name: name, description: description, **opts)
                        when :select
                          options = opts.delete(:options)
                          Controls::OptionsConfig.new(:select, options, default, param: param, name: name, description: description, **opts)
                        when :multi_select
                          options = opts.delete(:options)
                          Controls::MultiOptionsConfig.new(:'multi-select', options, default, param: param, name: name, description: description, **opts)
                        when :radio
                          options = opts.delete(:options)
                          Controls::OptionsConfig.new(:radio, options, default, param: param, name: name, description: description, **opts)
                        when :inline_radio
                          options = opts.delete(:options)
                          Controls::MultiOptionsConfigptionsConfig.new(:'inline-radio', options, default, param: param, name: name, description: description, **opts)
                        when :check
                          options = opts.delete(:options)
                          Controls::MultiOptionsConfig.new(:check, options, default, param: param, name: name, description: description, **opts)
                        when :inline_check
                          options = opts.delete(:options)
                          Controls::MultiOptionsConfig.new(:'inline-check', options, default, param: param, name: name, description: description, **opts)
                        when :date
                          Controls::DateConfig.new(default, param: param, name: name, description: description, **opts)
                        else
                          raise "Unknonwn control type '#{as}'"
                        end
          end
        end

        def text(default_value)
          Controls::TextConfig.new(default_value)
        end

        def boolean(default_value)
          Controls::BooleanConfig.new(default_value)
        end

        def number(default_value, min: nil, max: nil, step: nil)
          Controls::NumberConfig.new(:number, default_value, min: min, max: max, step: step)
        end

        def range(default_value, min: nil, max: nil, step: nil)
          Controls::NumberConfig.new(:range, default_value, min: min, max: max, step: step)
        end

        def color(default_value, preset_colors: nil)
          Controls::ColorConfig.new(default_value, preset_colors: preset_colors)
        end

        def object(default_value)
          Controls::ObjectConfig.new(default_value)
        end

        def select(options, default_value, labels: nil)
          Controls::OptionsConfig.new(:select, options, default_value, labels: labels)
        end

        def multi_select(options, default_value, labels: nil)
          Controls::MultiOptionsConfig.new(:'multi-select', options, default_value, labels: labels)
        end

        def radio(options, default_value, labels: nil)
          Controls::OptionsConfig.new(:radio, options, default_value, labels: labels)
        end

        def inline_radio(options, default_value, labels: nil)
          Controls::OptionsConfig.new(:'inline-radio', options, default_value, labels: labels)
        end

        def check(options, default_value, labels: nil)
          Controls::MultiOptionsConfig.new(:check, options, default_value, labels: labels)
        end

        def inline_check(options, default_value)
          Controls::MultiOptionsConfig.new(:'inline-check', options, default_value)
        end

        def array(default_value, separator = nil)
          ActiveSupport::Deprecation.warn("`array` `separator` argument will be removed in v1.0.0.") if separator
          Controls::ObjectConfig.new(default_value)
        end

        def date(default_value)
          Controls::DateConfig.new(default_value)
        end

        def custom(*args, **kwargs, &block)
          Controls::CustomConfig.new.with_value(*args, **kwargs, &block)
        end

        def klazz(value_class, *args, **kwargs)
          Controls::CustomConfig.new.with_value(*args, **kwargs) do |*a, **kwa|
            value_class.new(*a, **kwa)
          end
        end
      end
    end
  end
end
