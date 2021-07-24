# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Controls
      class BaseOptionsConfig < SimpleControlConfig
        attr_reader :type, :options, :labels

        validates :type, :options, presence: true

        def initialize(type, options, default_value, labels: nil, param: nil, name: nil)
          super(default_value, param: param, name: name)
          @type = type
          @options = options
          @labels = labels
        end

        def to_csf_params
          super.deep_merge(argTypes: { param => { options: options } })
        end

        private

        def csf_control_params
          labels.nil? ? super : super.merge(labels: labels)
        end
      end
    end
  end
end
