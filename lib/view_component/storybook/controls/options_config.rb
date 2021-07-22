# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Controls
      class OptionsConfig < SimpleControlConfig
        TYPES = %i[select multi-select radio inline-radio check inline-check].freeze

        attr_reader :type, :options, :symbol_value

        validates :type, :options, presence: true
        validates :type, inclusion: { in: TYPES }, unless: -> { type.nil? }
        validates :default_value, inclusion: { in: ->(config) { config.options } }, unless: -> { options.nil? || default_value.nil? }

        def initialize(type, options, default_value, param: nil, name: nil)
          super(default_value, param: param, name: name)
          @type = type
          @options = options
          @symbol_value = default_value.is_a?(Symbol)
        end

        def value_from_params(params)
          params_value = super(params)
          if params_value.is_a?(String) && symbol_value
            params_value.to_sym
          else
            params_value
          end
        end

        def to_csf_params
          super.deep_merge(argTypes: { param => { options: options } })
        end
      end
    end
  end
end
