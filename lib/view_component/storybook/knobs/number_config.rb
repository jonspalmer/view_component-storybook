# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Knobs
      class NumberConfig < KnobConfig
        attr_reader :options

        validates :value, presence: true

        def initialize(component, param, value, options = {}, name: nil, group_id: nil)
          super(component, param, value, name: name, group_id: group_id)
          @options = options
        end

        def type
          :number
        end

        def to_csf_params
          params = super
          params[:options] = options unless options.empty?
          params
        end

        def value_from_param(param)
          if param.is_a?(String) && param.present?
            (param.to_f % 1) > 0 ? param.to_f : param.to_i
          else
            super(param)
          end
        end
      end
    end
  end
end
