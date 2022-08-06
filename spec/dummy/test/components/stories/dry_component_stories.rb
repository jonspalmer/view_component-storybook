# frozen_string_literal: true

class DryComponentStories < ViewComponent::Storybook::Stories
  story :default do
    constructor(
      title: text("Hello World!")
    )
  end
end
