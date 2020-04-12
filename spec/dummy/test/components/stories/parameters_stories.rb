# frozen_string_literal: true

class ParametersStories < ViewComponent::Storybook::Stories
  parameters( size: :small )

  story :stories_parameters, Demo::ButtonComponent do
    knobs do
      button_text "OK"
    end
  end

  story :stories_parameter_override, Demo::ButtonComponent do
    parameters( size: :large, color: :red )
    knobs do
      button_text "OK"
    end
  end

  story :additional_parameters, Demo::ButtonComponent do
    parameters( color: :red )
    knobs do
      button_text "OK"
    end
  end
end
