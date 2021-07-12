# frozen_string_literal: true

class NoLayoutStories < ViewComponent::Storybook::Stories
  layout false

  story :default, Demo::ButtonComponent do
    constructor(
      button_text: text("OK")
    )
  end

  story :mobile_layout, Demo::ButtonComponent do
    constructor(
      button_text: text("OK")
    )
    layout "mobile"
  end
end
