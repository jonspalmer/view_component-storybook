# frozen_string_literal: true

module ViewComponent
  module Storybook
    class Story
      include ActiveModel::Validations

      attr_reader :component, :content_block, :layout

      def initialize(component, content_block, layout)
        @component = component
        @content_block = content_block
        @layout = layout
      end
    end
  end
end
