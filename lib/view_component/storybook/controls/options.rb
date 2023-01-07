# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Controls
      class Options < BaseOptions
        TYPES = %i[select radio inline-radio].freeze

        validates :type, inclusion: { in: TYPES }, unless: -> { type.nil? }
        validates :default, inclusion: { in: ->(config) { config.options } }, unless: -> { options.nil? || default.nil? }

        def parse_param_value(value)
          if value.is_a?(String) && symbol_value
            value.to_sym
          else
            value
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
          @symbol_value ||= default.is_a?(Symbol)
        end
      end
    end
  end
end
