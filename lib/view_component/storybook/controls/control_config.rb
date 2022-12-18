# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Controls
      class ControlConfig
        include ActiveModel::Validations

        validates :param, presence: true

        attr_reader :opts

        def initialize(param: nil, name: nil, description: nil, **opts)
          @param = param
          @name = name
          @description = description
          @opts = opts
        end

        def name(new_name = nil)
          if new_name.nil?
            @name ||= param.to_s.humanize.titlecase
          else
            @name = new_name
            self
          end
        end

        def description(new_description = nil)
          return @description if new_description.nil?

          @description = new_description
          self
        end

        def param(new_param = nil)
          return @param if new_param.nil?

          @param = new_param
          self
        end

        def prefix_param(prefix)
          param("#{prefix}__#{@param}".to_sym)
        end

        def to_csf_params
          # :nocov:
          raise NotImplementedError
          # :nocov:
        end

        def value_from_params(params)
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
