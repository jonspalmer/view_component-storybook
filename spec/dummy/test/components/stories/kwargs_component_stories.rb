# frozen_string_literal: true

class KwargsComponentStories < ViewComponent::Storybook::Stories
  story :default do
    constructor(
      message: text("Hello World!"),
      param: number(1),
      other_param: boolean(true)
    )
  end

  story :fixed_args do
    constructor(
      message: text("Hello World!"),
      param: 1,
      other_param: true
    )
  end

  story :custom_param do
    constructor(
      message: text("Hello World!").param(:my_message),
      param: number(1)
    )
  end
end
