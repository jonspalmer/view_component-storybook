# frozen_string_literal: true

module Invalid
  class DuplicateStoryStories < ViewComponent::Storybook::Stories
    story :my_story, ExampleComponent do
      constructor(
        title: text("OK")
      )
    end

    story :my_story, ExampleComponent do
      constructor(
        title: text("Not OK!")
      )
    end
  end
end
