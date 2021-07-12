# frozen_string_literal: true

class LayoutStories < ViewComponent::Storybook::Stories
  layout "admin"

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

  story :no_layout, Demo::ButtonComponent do
    constructor(
      button_text: text("OK")
    )
    layout false
  end
end
