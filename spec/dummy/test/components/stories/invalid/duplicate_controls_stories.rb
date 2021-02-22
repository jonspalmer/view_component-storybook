# frozen_string_literal: true

module Invalid
  class DuplicateControlsStories < ViewComponent::Storybook::Stories
    story :duplicate_controls, ExampleComponent do
      controls do
        title "OK"
        title "Not OK!"
      end
    end
  end
end
