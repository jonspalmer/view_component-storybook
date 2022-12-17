# frozen_string_literal: true

class NoLayoutStories < ViewComponent::Storybook::Stories
  layout false

  # @control button_text text
  def default(button_text: "OK")
    render Demo::ButtonComponent.new(button_text: button_text)
  end

  # # @control button_text text
  # # @layout mobile
  # def mobile_layout(button_text: "OK")
  #   render Demo::ButtonComponent.new(button_text: button_text)
  # end
end
