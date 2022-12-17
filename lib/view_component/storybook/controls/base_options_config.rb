# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Controls
      class BaseOptionsConfig < SimpleControlConfig
        attr_reader :type, :options, :labels

        validates :type, :options, presence: true

        def initialize(param, type, options, default: , labels: nil, name: nil, description: nil, **opts)
          super(param, default: default, name: name, description: description, **opts)
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
