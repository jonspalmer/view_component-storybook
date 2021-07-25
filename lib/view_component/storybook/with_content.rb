# frozen_string_literal: true

module ViewComponent
  module Storybook
    module WithContent
      attr_reader :content_control, :content_block

      def content(content = nil, &block)
        case content
        when Storybook::Controls::ControlConfig
          @content_control = content.param(content_param)
          @content_block = nil
        when String
          @content_control = nil
          @content_block = proc { content }
        else
          @content_control = nil
          @content_block = block
        end
      end

      def resolve_content_block(params)
        if content_control
          content = content_control.value_from_params(params)
          proc { content }
        else
          content_block
        end
      end

      private

      def content_param
        :content
      end
    end
  end
end
