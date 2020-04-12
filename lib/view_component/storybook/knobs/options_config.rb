# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Knobs
      class OptionsConfig < KnobConfig
        TYPES = %i[select radios].freeze

        attr_reader :type, :options

        validates :value, :type, :options, presence: true
        validates :type, inclusion: { in: TYPES }, unless: -> { type.nil? }
        validates :value, inclusion: { in: ->(config) { config.options.values } }, unless: -> { options.nil? || value.nil? }

        def initialize(type, component, param, options, default_value, name: nil, group_id: nil)
          super(component, param, default_value, name: name, group_id: group_id)
          @type = type
          @options = options
        end

        def to_csf_params
          super.merge(options: options)
        end
      end
    end
  end
end
