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

          def control(param, as:, default:, **opts)
            controls << case as
                        when :text
                          Controls::TextConfig.new(param, default: default, **opts)
                        when :boolean
                          Controls::BooleanConfig.new(param, default: default, **opts)
                        when :number
                          Controls::NumberConfig.new(param, type: :number, default: default, **opts)
                        when :range
                          Controls::NumberConfig.new(param, type: :range, default: default, **opts)
                        when :color
                          Controls::ColorConfig.new(param, default: default, **opts)
                        when :object, :array
                          Controls::ObjectConfig.new(param, default: default, **opts)
                        when :select
                          Controls::OptionsConfig.new(param, type: :select, default: default, **opts)
                        when :multi_select
                          Controls::MultiOptionsConfig.new(param, type: :'multi-select', default: default, **opts)
                        when :radio
                          Controls::OptionsConfig.new(param, type: :radio, default: default, **opts)
                        when :inline_radio
                          Controls::OptionsConfig.new(param, type: :'inline-radio', default: default, **opts)
                        when :check
                          Controls::MultiOptionsConfig.new(param, type: :check, default: default, **opts)
                        when :inline_check
                          Controls::MultiOptionsConfig.new(param, type: :'inline-check', default: default, **opts)
                        when :date
                          Controls::DateConfig.new(param, default: default, **opts)
                        else
                          raise "Unknonwn control type '#{as}'"
                        end
          end
        end
      end
    end
  end
end
