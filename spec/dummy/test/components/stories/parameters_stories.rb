# frozen_string_literal: true

class ParametersStories < ViewComponent::Storybook::Stories
  parameters( size: :small )

  story :stories_parameters, Demo::ButtonComponent do
    controls do
      button_text "OK"
    end
  end

  story :stories_parameter_override, Demo::ButtonComponent do
    parameters( size: :large, color: :red )
    controls do
      button_text "OK"
    end
  end

  story :additional_parameters, Demo::ButtonComponent do
    parameters( color: :red )
    controls do
      button_text "OK"
    end
  end
end
