# frozen_string_literal: true

module Demo
  class ButtonComponentStories < ViewComponent::Storybook::Stories
    control :button_text, as: :text

    def short_button(button_text: "OK")
      render ButtonComponent.new(button_text: button_text)
    end

    def medium_button(button_text: "Push Me!")
      render ButtonComponent.new(button_text: button_text)
    end

    def long_button(button_text: "Really Really Long Button Text")
      render ButtonComponent.new(button_text: button_text)
    end
  end
end
