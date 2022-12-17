# frozen_string_literal: true

class LayoutStories < ViewComponent::Storybook::Stories
  layout "admin"

  control :button_text, as: :text, default: "OK"

  def default(button_text: "OK")
    render Demo::ButtonComponent.new(button_text: button_text)
  end

  # # @layout mobile
  # def mobile_layout(button_text: "OK")
  #   render Demo::ButtonComponent.new(button_text: button_text)
  # end

  # # @layout false
  # def no_layout(button_text: "OK")
  #   render Demo::ButtonComponent.new(button_text: button_text)
  # end
end
