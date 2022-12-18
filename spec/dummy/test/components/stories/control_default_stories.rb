# frozen_string_literal: true

class ControlDefaultStories < ViewComponent::Storybook::Stories
  control :content, as: :text, default: "Hello World!"

  def example(content: "Ignored")
    render(ContentComponent.new) do
      content
    end
  end
end
