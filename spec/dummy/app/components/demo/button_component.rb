# frozen_string_literal: true

module Demo
  class ButtonComponent < ViewComponent::Base
    def initialize(button_text:)
      super
      @button_text = button_text
    end

    private

    attr_reader :button_text
  end
end
