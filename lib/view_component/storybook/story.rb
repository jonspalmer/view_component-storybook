# frozen_string_literal: true

module ViewComponent
  module Storybook
    class Story

      attr_reader :id, :name, :parameters, :controls

      def initialize(id, name, parameters, controls)
        @id = id
        @name = name
        @parameters = parameters
        @controls = controls
      end

      def to_csf_params
        csf_params = { name: name, parameters: { server: { id: id } } }
        csf_params.deep_merge!(parameters: parameters) if parameters.present?
        controls.each do |control|
          csf_params.deep_merge!(control.to_csf_params)
        end
        csf_params
      end

      def self.from_code_object(code_object, stories_config)
        name = code_object.name
        id = "#{stories_config.stories_name}/#{name.to_s.parameterize}".underscore

        self.new(id, name, {}, [])
      end
    end
  end
end
