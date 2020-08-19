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
          @options = expand_options(options)
        end

        private

        def expand_options(options)
          case options
          when Hash
            options
          when Array
            array_to_hash(options)
          else
            raise "Options must be either an Array or Hash"
          end
        end

        def array_to_hash(arr)
          arr.each_with_object({}) { |k, h| h[k] = k }
        end

        def csf_control_params
          super.merge(options: options)
        end
      end
    end
  end
end
