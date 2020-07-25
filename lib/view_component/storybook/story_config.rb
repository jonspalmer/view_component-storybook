# frozen_string_literal: true

module ViewComponent
  module Storybook
    class StoryConfig
      include ActiveModel::Validations

      attr_reader :id, :name, :component
      attr_accessor :controls, :parameters, :layout, :content_block

      def initialize(id, name, component, layout)
        @id = id
        @name = name
        @component = component
        @layout = layout
        @controls = []
      end

      def to_csf_params
        csf_params = { name: name, parameters: { server: { id: id } } }
        csf_params.deep_merge!(parameters: parameters) if parameters.present?
        controls.each do |control|
          csf_params.deep_merge!(control.to_csf_params)
        end
        csf_params
      end

      def values_from_params(params)
        controls.map do |control|
          value = control.value_from_param(params[control.param])
          value = control.value if value.nil? # nil only not falsey
          [control.param, value]
        end.to_h
      end

      def self.configure(id, name, component, layout, &configuration)
        config = new(id, name, component, layout)
        ViewComponent::Storybook::Dsl::StoryDsl.evaluate!(config, &configuration)
        config
      end
    end
  end
end
