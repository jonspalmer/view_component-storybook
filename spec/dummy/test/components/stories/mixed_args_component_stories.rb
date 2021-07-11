# frozen_string_literal: true

class MixedArgsComponentStories < ViewComponent::Storybook::Stories
  story :default do
    constructor(text(:title, "Hello World!"), message: text(:message, "How you doing?"))
  end
end
