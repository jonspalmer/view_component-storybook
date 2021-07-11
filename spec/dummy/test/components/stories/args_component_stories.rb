# frozen_string_literal: true

class ArgsComponentStories < ViewComponent::Storybook::Stories
  story :default do
    constructor(text("Hello World!", param: :first), text("How you doing?", param: :second))
  end
end
