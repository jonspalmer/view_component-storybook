# frozen_string_literal: true

class ArgsComponentStories < ViewComponent::Storybook::Stories
  story :default do
    constructor(text(:first, "Hello World!"), text(:second, "How you doing?"))
  end
end
