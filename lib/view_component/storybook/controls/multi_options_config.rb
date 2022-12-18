# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Controls
      class MultiOptionsConfig < BaseOptionsConfig
        TYPES = %i[multi-select check inline-check].freeze

        validates :type, inclusion: { in: TYPES }, unless: -> { type.nil? }
        validate :validate_default_value, unless: -> { options.nil? || default.nil? }

        def initialize(param, type:, options:, default:, labels: nil, name: nil, description: nil, **opts)
          super(param, type: type, options: options, default: Array.wrap(default), labels: labels, param: param, name: name, description: description, **opts)
        end

        def value_from_params(params)
          params_value = super(params)

          if params_value.is_a?(String)
            params_value = params_value.split(',')
            params_value = params_value.map(&:to_sym) if symbol_values
          end
          params_value
        end

        def to_csf_params
          super.deep_merge(argTypes: { param => { options: options } })
        end

        private

        def csf_control_params
          labels.nil? ? super : super.merge(labels: labels)
        end

        def symbol_values
          @symbol_values ||= default.first.is_a?(Symbol)
        end

        def validate_default_value
          errors.add(:default, :inclusion) unless default.to_set <= options.to_set
        end
      end
    end
  end
end
