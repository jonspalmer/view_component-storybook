# frozen_string_literal: true

module Invalid
  class InvalidConstructorStories < ViewComponent::Storybook::Stories
    story :invalid_kwards, ExampleComponent do
      constructor(title: "OK", junk: "Not OK!")
    end
  end
end
