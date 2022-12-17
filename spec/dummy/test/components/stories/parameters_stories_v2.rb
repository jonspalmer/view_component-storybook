# frozen_string_literal: true

class ParametersStoriesV2 < ViewComponent::Storybook::StoriesV2
  parameters( size: :small )

  # @control button_text text
  def stories_parameters(button_text: "OK")
    render Demo::ButtonComponent.new(button_text: button_text)
  end
  
  # @control button_text text
  # @parameters {size: :large, color: :red}
  def stories_parameters(button_text: "OK")
    render Demo::ButtonComponent.new(button_text: button_text)
  end

  # @control button_text text
  # @parameters {color: :red}
  def additional_parameters(button_text: "OK")
    render Demo::ButtonComponent.new(button_text: button_text)
  end
end
