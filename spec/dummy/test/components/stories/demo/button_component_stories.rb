# frozen_string_literal: true

module Demo
  class ButtonComponentStories < ViewComponent::Storybook::Stories
    story :short_button do
      constructor(
        button_text: text("OK")
      )
    end

    story :medium_button do
      constructor(
        button_text: text("Push Me!")
      )
    end

    story :long_button do
      constructor(
        button_text: text("Really Really Long Button Text")
      )
    end
  end
end
