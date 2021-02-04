# frozen_string_literal: true

class KwargsComponentStories < ViewComponent::Storybook::Stories
  story :default do
    controls do
      message "Hello World!"
      param 1
      other_param true
    end
  end
end
