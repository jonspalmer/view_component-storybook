# frozen_string_literal: true

class ContentComponentStories < ViewComponent::Storybook::Stories
  story :default do
    content do
      "Hello World!"
    end
  end

  story :with_helper_content do
    content do
      link_to 'Hello World!', '#'
    end
  end
end
