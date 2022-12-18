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
                          Controls::Text.new(param, **opts)
                        when :boolean
                          Controls::Boolean.new(param, **opts)
                        when :number
                          Controls::Number.new(param, type: :number, **opts)
                        when :range
                          Controls::Number.new(param, type: :range, **opts)
                        when :color
                          Controls::Color.new(param, **opts)
                        when :object, :array
                          Controls::Object.new(param, **opts)
                        when :select
                          Controls::Options.new(param, type: :select, **opts)
                        when :multi_select
                          Controls::MultiOptions.new(param, type: :'multi-select', **opts)
                        when :radio
                          Controls::Options.new(param, type: :radio, **opts)
                        when :inline_radio
                          Controls::Options.new(param, type: :'inline-radio', **opts)
                        when :check
                          Controls::MultiOptions.new(param, type: :check, **opts)
                        when :inline_check
                          Controls::MultiOptions.new(param, type: :'inline-check', **opts)
                        when :date
                          Controls::Date.new(param, **opts)
                        else
                          raise "Unknonwn control type '#{as}'"
                        end
          end
        end
      end
    end
  end
end
