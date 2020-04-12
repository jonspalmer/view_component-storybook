# frozen_string_literal: true

module Demo
  class ButtonComponentStories < ViewComponent::Storybook::Stories
    story :short_button do
      knobs do
        button_text "OK"
      end
    end

    story :medium_button do
      knobs do
        button_text "Push Me!"
      end
    end

    story :long_button do
      knobs do
        button_text "Really Really Long Button Text"
      end
    end
  end
end
