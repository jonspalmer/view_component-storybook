# frozen_string_literal: true

class ContentComponentStories < ViewComponent::Storybook::Stories
  story :default do
    content do
      "Hello World!"
    end
  end
end
