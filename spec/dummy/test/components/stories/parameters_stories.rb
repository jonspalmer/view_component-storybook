# frozen_string_literal: true

class ParametersStories < ViewComponent::Storybook::Stories
  parameters( size: :small )

  story :stories_parameters, Demo::ButtonComponent do
    constructor(
      button_text: text("OK")
    )
  end

  story :stories_parameter_override, Demo::ButtonComponent do
    parameters( size: :large, color: :red )
    constructor(
      button_text: text("OK")
    )
  end

  story :additional_parameters, Demo::ButtonComponent do
    parameters( color: :red )
    constructor(
      button_text: text("OK")
    )
  end
end
