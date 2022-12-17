# frozen_string_literal: true

module Demo
  class ButtonComponentStories < ViewComponent::Storybook::Stories
    control :button_text, as: :text, default: "OK", only: :short_button

    def short_button(button_text: "OK")
      render ButtonComponent.new(button_text: button_text)
    end

    control :button_text, as: :text, default: "Push Me!", only: :medium_button

    def medium_button(button_text: "Push Me!")
      render ButtonComponent.new(button_text: button_text)
    end

    control :button_text, as: :text, default: "Really Really Long Button Text", only: :long_button

    def long_button(button_text: "Really Really Long Button Text")
      render ButtonComponent.new(button_text: button_text)
    end
  end
end
