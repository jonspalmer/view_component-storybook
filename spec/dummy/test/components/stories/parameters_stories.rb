# frozen_string_literal: true

class ParametersStories < ViewComponent::Storybook::Stories
  parameters( size: :small )

  control :button_text, as: :text, default: "OK"

  def stories_parameters(button_text: "OK")
    render Demo::ButtonComponent.new(button_text: button_text)
  end

  # @parameters {size: :large, color: :red}
  def stories_parameters(button_text: "OK")
    render Demo::ButtonComponent.new(button_text: button_text)
  end

  # @parameters {color: :red}
  def additional_parameters(button_text: "OK")
    render Demo::ButtonComponent.new(button_text: button_text)
  end
end
