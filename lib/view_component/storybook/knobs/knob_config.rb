# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Knobs
      class KnobConfig
        include ActiveModel::Validations

        attr_reader :component, :param, :value, :name, :group_id

        validates :component, :param, presence: true
        validates :param, inclusion: { in: ->(knob_config) { knob_config.component_params } }, unless: -> { component.nil? }

        def initialize(component, param, value, name: nil, group_id: nil)
          @component = component
          @param = param
          @value = value
          @name = name || param.to_s.humanize.titlecase
          @group_id = group_id
        end

        def to_csf_params
          validate!
          params = { type: type, param: param, name: name, value: value }
          params[:group_id] = group_id if group_id
          params
        end

        def value_from_param(param)
          param
        end

        def component_params
          @component_params ||= component && component.instance_method(:initialize).parameters.map(&:last)
        end
      end
    end
  end
end
