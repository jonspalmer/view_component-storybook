# frozen_string_literal: true

class MixedArgsComponentStories < ViewComponent::Storybook::Stories
  story :default do
    constructor(text("Hello World!", param: :title), message: text("How you doing?"))
  end

  story :fixed_args do
    constructor("Hello World!", message: "How you doing?")
  end
end
