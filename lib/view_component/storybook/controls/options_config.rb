# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Controls
      class OptionsConfig < ControlConfig
        TYPES = %i[select multi-select radio inline-radio check inline-check].freeze

        attr_reader :type, :options

        validates :value, :type, :options, presence: true
        validates :type, inclusion: { in: TYPES }, unless: -> { type.nil? }
        validates :value, inclusion: { in: ->(config) { config.options.values } }, unless: -> { options.nil? || value.nil? }

        def initialize(type, component, param, options, default_value, name: nil)
          super(component, param, default_value, name: name)
          @type = type
          @options = options
        end

        private

        def csf_control_params
          super.merge(options: options)
        end
      end
    end
  end
end
