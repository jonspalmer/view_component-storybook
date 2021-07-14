# frozen_string_literal: true

class ContentComponentStories < ViewComponent::Storybook::Stories
  story :with_string_content do
    content "Hello World!"
  end

  story :with_block_content do
    content do
      "Hello World!"
    end
  end

  story :with_helper_content do
    content do
      link_to "Hello World!", "#"
    end
  end

  story :with_constructor_content do
    constructor do
      "Hello World!"
    end
  end
end
