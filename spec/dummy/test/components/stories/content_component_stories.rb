# frozen_string_literal: true

class ContentComponentStories < ViewComponent::Storybook::Stories
  story :with_string_content do
    with_content "Hello World!"
  end

  story :with_control_content do
    with_content text("Hello World!")
  end

  story :with_block_content do
    with_content do
      "Hello World!"
    end
  end

  story :with_helper_content do
    with_content do
      link_to "Hello World!", "#"
    end
  end

  story :with_constructor_content do
    constructor do
      "Hello World!"
    end
  end
end
