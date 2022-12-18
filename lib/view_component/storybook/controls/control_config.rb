# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Controls
      class ControlConfig
        include ActiveModel::Validations

        validates :param, presence: true

        attr_reader :param, :name, :description, :opts
        attr_accessor :default

        def initialize(param, default:, name: nil, description: nil, **opts)
          @param = param
          @default = default
          @name = name || param.to_s.humanize.titlecase
          @description = description
          @opts = opts
        end

        def to_csf_params
          # :nocov:
          raise NotImplementedError
          # :nocov:
        end

        def parse_param_value(value)
          # :nocov:
          raise NotImplementedError
          # :nocov:
        end

        def valid_for_story?(story_name)
          # expand to include arrays of names
          # expand to include except
          opts[:only].nil? || opts[:only] == story_name
        end
      end
    end
  end
end
