# frozen_string_literal: true

class DryComponentStories < ViewComponent::Storybook::Stories
  control :title, as: :text

  def default(title: "Hello World!")
    render DryComponent.new(title: title)
  end
end
