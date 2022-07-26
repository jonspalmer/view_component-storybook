# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Controls
      class BaseOptionsConfig < SimpleControlConfig
        attr_reader :type, :options, :labels

        validates :type, :options, presence: true

        def initialize(type, options, default_value, labels: nil, param: nil, name: nil, description: nil)
          super(default_value, param: param, name: name, description: description)
          @type = type
          @options = options
          @labels = labels
          normalize_options
        end

        def to_csf_params
          super.deep_merge(argTypes: { param => { options: options } })
        end

        private

        def csf_control_params
          labels.nil? ? super : super.merge(labels: labels)
        end

        def normalize_options
          return unless options.is_a?(Hash)

          warning = "Hash options is deprecated and will be removed in v1.0.0. Use array options and `labels` instead."
          ActiveSupport::Deprecation.warn(warning)

          @labels = options.invert
          @options = options.values
        end
      end
    end
  end
end
