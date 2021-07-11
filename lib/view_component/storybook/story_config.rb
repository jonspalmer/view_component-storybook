# frozen_string_literal: true

module ViewComponent
  module Storybook
    class StoryConfig
      include ActiveModel::Validations

      attr_reader :id, :name, :component
      attr_accessor :controls, :parameters, :layout, :content_block

      validate :valid_controls

      def initialize(id, name, component, layout)
        @id = id
        @name = name
        @component = component
        @layout = layout
        @controls = []
      end

      def to_csf_params
        validate!
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

      def validate!
        valid? || raise(ValidationError, self)
      end

      def self.configure(id, name, component, layout, &configuration)
        config = new(id, name, component, layout)
        ViewComponent::Storybook::Dsl::StoryDsl.evaluate!(config, &configuration)
        config
      end

      protected

      def valid_controls
        controls.reject(&:valid?).each do |control|
          errors.add(:controls, :invalid, value: control)
        end

        control_names = controls.map(&:name)
        duplicate_names = control_names.group_by(&:itself).map { |k, v| k if v.length > 1 }.compact
        return if duplicate_names.empty?

        errors.add(:controls, :invalid, message: "duplicate control #{'name'.pluralize(duplicate_names.count)} #{duplicate_names.to_sentence}")
      end

      class ValidationError < StandardError
        attr_reader :story_config

        def initialize(story_config)
          @story_config = story_config
          errors = @story_config.errors.full_messages
          errors += @story_config.controls.map do |control|
            "Control '#{control.name}' invalid: #{control.errors.full_messages.join(', ')}." if control.errors.present?
          end

          super("'#{@story_config.name}' invalid: #{errors.compact.join(', ')}")
        end
      end
    end
  end
end
