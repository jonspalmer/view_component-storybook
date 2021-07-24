# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Controls
      class OptionsConfig < BaseOptionsConfig
        TYPES = %i[select multi-select radio inline-radio check inline-check].freeze

        validates :type, inclusion: { in: TYPES }, unless: -> { type.nil? }
        validates :default_value, inclusion: { in: ->(config) { config.options } }, unless: -> { options.nil? || default_value.nil? }

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

        private

        def csf_control_params
          labels.nil? ? super : super.merge(labels: labels)
        end

        def symbol_value
          @symbol_value ||= default_value.is_a?(Symbol)
        end
      end
    end
  end
end
