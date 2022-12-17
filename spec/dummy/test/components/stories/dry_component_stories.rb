# frozen_string_literal: true

class DryComponentStories < ViewComponent::Storybook::Stories
  control :title, as: :text, default: "Hello World!"

  def default(title: "Hello World!")
    render DryComponent.new(title: title)
  end
end
