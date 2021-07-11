# frozen_string_literal: true

class ArgsComponentStories < ViewComponent::Storybook::Stories
  story :default do
    constructor(
      text("Hello World!", param: :first),
      text("How you doing?", param: :second)
    )
  end

  story :fixed_args do
    constructor(
      text("Hello World!", param: :first),
      "How you doing?"
    )
  end

  story :custom_param do
    constructor(
      text("Hello World!", param: :message),
      text("How you doing?", param: :second)
    )
  end
end
