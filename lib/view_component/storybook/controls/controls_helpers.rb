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

          def control(param, as:, **opts)
            controls << case as
                        when :text
                          Controls::TextConfig.new(param, **opts)
                        when :boolean
                          Controls::BooleanConfig.new(param, **opts)
                        when :number
                          Controls::NumberConfig.new(param, type: :number, **opts)
                        when :range
                          Controls::NumberConfig.new(param, type: :range, **opts)
                        when :color
                          Controls::ColorConfig.new(param, **opts)
                        when :object, :array
                          Controls::ObjectConfig.new(param, **opts)
                        when :select
                          Controls::OptionsConfig.new(param, type: :select, **opts)
                        when :multi_select
                          Controls::MultiOptionsConfig.new(param, type: :'multi-select', **opts)
                        when :radio
                          Controls::OptionsConfig.new(param, type: :radio, **opts)
                        when :inline_radio
                          Controls::OptionsConfig.new(param, type: :'inline-radio', **opts)
                        when :check
                          Controls::MultiOptionsConfig.new(param, type: :check, **opts)
                        when :inline_check
                          Controls::MultiOptionsConfig.new(param, type: :'inline-check', **opts)
                        when :date
                          Controls::DateConfig.new(param, **opts)
                        else
                          raise "Unknonwn control type '#{as}'"
                        end
          end
        end
      end
    end
  end
end
