# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Controls
      class ControlConfig
        include ActiveModel::Validations

        attr_reader :component, :param, :value, :name

        validates :component, :param, presence: true
        validates :param, inclusion: { in: ->(control_config) { control_config.component_param_names } }, if: :should_validate_params?

        def initialize(component, param, value, name: nil)
          @component = component
          @param = param
          @value = value
          @name = name || param.to_s.humanize.titlecase
        end

        def to_csf_params
          validate!
          {
            args: { param => csf_value },
            argTypes: { param => { control: csf_control_params, name: name } }
          }
        end

        def value_from_param(param)
          param
        end

        def component_param_names
          @component_param_names ||= component_params&.map(&:last)
        end

        private

        # provide extension points for subclasses to vary the value
        def csf_value
          value
        end

        def csf_control_params
          { type: type }
        end

        def component_accepts_kwargs?
          component_params.map(&:first).include?(:keyrest)
        end

        def component_params
          @component_params ||= component.instance_method(:initialize).parameters
        end

        def should_validate_params?
          !component.nil? && !component_accepts_kwargs?
        end
      end
    end
  end
end
