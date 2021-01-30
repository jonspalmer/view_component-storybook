# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Controls
      class OptionsConfig < ControlConfig
        class << self
          # support the options being a Hash or an Array. Storybook supports either.
          def inclusion_in(config)
            case config.options
            when Hash
              config.options.values
            when Array
              config.options
            else
              []
            end
          end
        end

        TYPES = %i[select multi-select radio inline-radio check inline-check].freeze

        attr_reader :type, :options, :symbol_value

        validates :type, :options, presence: true
        validates :type, inclusion: { in: TYPES }, unless: -> { type.nil? }
        validates :value, inclusion: { in: method(:inclusion_in) }, unless: -> { options.nil? || value.nil? }

        def initialize(type, component, param, options, default_value, name: nil)
          super(component, param, default_value, name: name)
          @type = type
          @options = options
          @symbol_value = default_value.is_a?(Symbol)
        end

        def value_from_param(param)
          if param.is_a?(String) && symbol_value
            param.to_sym
          else
            super(param)
          end
        end

        private

        def csf_control_params
          super.merge(options: options)
        end
      end
    end
  end
end
