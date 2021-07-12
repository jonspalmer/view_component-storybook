# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Controls
      class ArrayConfig < SimpleControlConfig
        attr_reader :separator

        validates :separator, presence: true

        def initialize(default_value, separator = ",", param: nil, name: nil)
          super(default_value, param: param, name: name)
          @separator = separator
        end

        def type
          :array
        end

        def value_from_params(params)
          params_value = super(params)
          if params_value.is_a?(String)
            params_value.split(separator)
          else
            params_value
          end
        end

        private

        def csf_control_params
          super.merge(separator: separator)
        end
      end
    end
  end
end
