# frozen_string_literal: true

module ViewComponent
  module Storybook
    class StoryConfig
      include ActiveModel::Validations

      attr_reader :id, :name, :component
      attr_accessor :knobs, :parameters, :layout, :content_block

      def initialize(id, name, component, layout)
        @id = id
        @name = name
        @component = component
        @layout = layout
        @knobs = []
      end

      def to_csf_params
        csf_params = { name: name, parameters: { server: { id: id } } }
        csf_params.deep_merge!(parameters: parameters) if parameters.present?
        csf_params[:knobs] = knobs.map(&:to_csf_params) if knobs.present?
        csf_params
      end

      def values_from_params(params)
        knobs.map do |knob|
          value = knob.value_from_param(params[knob.param])
          value = knob.value if value.nil? # nil only not falsey
          [knob.param, value]
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
