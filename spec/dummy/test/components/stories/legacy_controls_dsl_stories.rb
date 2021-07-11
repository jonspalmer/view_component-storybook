# frozen_string_literal: true

class LegacyControlsDslStories < ViewComponent::Storybook::Stories
  story :short_button, Demo::ButtonComponent do
    controls do
      button_text "OK"
    end
  end
end
