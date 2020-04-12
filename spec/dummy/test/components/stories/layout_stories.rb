# frozen_string_literal: true

class LayoutStories < ViewComponent::Storybook::Stories
  layout "admin"

  story :default, Demo::ButtonComponent do
    knobs do
      button_text "OK"
    end
  end

  story :mobile_layout, Demo::ButtonComponent do
    knobs do
      button_text "OK"
    end
    layout "mobile"
  end

  story :no_layout, Demo::ButtonComponent do
    knobs do
      button_text "OK"
    end
    layout false
  end
end
