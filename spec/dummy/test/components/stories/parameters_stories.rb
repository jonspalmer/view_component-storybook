# frozen_string_literal: true

class ParametersStories < ViewComponent::Storybook::Stories
  parameters({ size: :small })

  control :button_text, as: :text

  def stories_parameters(button_text: "OK")
    render Demo::ButtonComponent.new(button_text: button_text)
  end

  parameters({ size: :large, color: :red }, only: :stories_parameter_override)

  def stories_parameter_override(button_text: "OK")
    render Demo::ButtonComponent.new(button_text: button_text)
  end

  parameters({ color: :red }, only: :additional_parameters)

  def additional_parameters(button_text: "OK")
    render Demo::ButtonComponent.new(button_text: button_text)
  end
end
