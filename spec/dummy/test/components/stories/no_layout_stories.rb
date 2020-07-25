# frozen_string_literal: true

class NoLayoutStories < ViewComponent::Storybook::Stories
  layout false

  story :default, Demo::ButtonComponent do
    controls do
      button_text "OK"
    end
  end

  story :mobile_layout, Demo::ButtonComponent do
    controls do
      button_text "OK"
    end
    layout "mobile"
  end
end
