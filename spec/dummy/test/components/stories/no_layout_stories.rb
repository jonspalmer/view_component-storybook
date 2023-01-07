# frozen_string_literal: true

class NoLayoutStories < ViewComponent::Storybook::Stories
  layout false

  control :button_text, as: :text

  def default(button_text: "OK")
    render Demo::ButtonComponent.new(button_text: button_text)
  end

  layout("mobile", only: :mobile_layout)
  def mobile_layout(button_text: "OK")
    render Demo::ButtonComponent.new(button_text: button_text)
  end
end
