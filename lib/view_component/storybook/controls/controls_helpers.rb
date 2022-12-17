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
                          Controls::TextConfig.new(param, default: default, name: name, description: description, **opts)
                        when :boolean
                          Controls::BooleanConfig.new(param, default: default, name: name, description: description, **opts)
                        when :number
                          Controls::NumberConfig.new(param, :number, default: default, name: name, description: description, **opts)
                        when :range
                          Controls::NumberConfig.new(param, :range, default: default, name: name, description: description, **opts)
                        when :color
                          Controls::ColorConfig.new(param, default: default, name: name, description: description, **opts)
                        when :object, :array
                          Controls::ObjectConfig.new(param, default: default, name: name, description: description, **opts)
                        when :select
                          options = opts.delete(:options)
                          Controls::OptionsConfig.new(param, :select, options, default: default, name: name, description: description, **opts)
                        when :multi_select
                          options = opts.delete(:options)
                          Controls::MultiOptionsConfig.new(param, :'multi-select', options, default: default, name: name, description: description, **opts)
                        when :radio
                          options = opts.delete(:options)
                          Controls::OptionsConfig.new(param, :radio, options, default: default, name: name, description: description, **opts)
                        when :inline_radio
                          options = opts.delete(:options)
                          Controls::OptionsConfig.new(param, :'inline-radio', options, default: default,  name: name, description: description, **opts)
                        when :check
                          options = opts.delete(:options)
                          Controls::MultiOptionsConfig.new(param, :check, options, default: default,  name: name, description: description, **opts)
                        when :inline_check
                          options = opts.delete(:options)
                          Controls::MultiOptionsConfig.new(param, :'inline-check', options, default: default, name: name, description: description, **opts)
                        when :date
                          Controls::DateConfig.new(param, default: default, name: name, description: description, **opts)
                        else
                          raise "Unknonwn control type '#{as}'"
                        end
          end
        end
      end
    end
  end
end
