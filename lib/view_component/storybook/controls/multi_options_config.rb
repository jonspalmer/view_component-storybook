# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Controls
      class MultiOptionsConfig < BaseOptionsConfig
        TYPES = %i[multi-select check inline-check].freeze

        validates :type, inclusion: { in: TYPES }, unless: -> { type.nil? }
        validate :validate_default_value, unless: -> { options.nil? || default_value.nil? }

        def initialize(type, options, default_value, labels: nil, param: nil, name: nil, description: nil)
          super(type, options, Array.wrap(default_value), labels: labels, param: param, name: name, description: description)
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
          @symbol_values ||= default_value.first.is_a?(Symbol)
        end

        def validate_default_value
          errors.add(:default_value, :inclusion) unless default_value.to_set <= options.to_set
        end
      end
    end
  end
end
