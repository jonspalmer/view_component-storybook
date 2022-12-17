# frozen_string_literal: true

class ContentComponentStories < ViewComponent::Storybook::Stories

  def with_string_content
    render(ContentComponent.new) do
      "Hello World!"
    end
  end

  # controls(only: :with_described_control) do
  #   text(:content, "Hello World")
  # end

  control :content, as: :text, default: "Hello World!", only: :with_control_content

  def with_control_content(content: "Hello World!")
    render(ContentComponent.new) do
      content
    end
  end

  # controls(only: :with_described_control) do
  #   text(:content, "Hello World", description: "My first computer program.")
  # end

  control :content, as: :text, default: "Hello World!", description: "My first computer program.", only: :with_described_control

  def with_described_control(content: "Hello World!")
    render(ContentComponent.new) do
      content
    end
  end

  def with_helper_content
    render(ContentComponent.new) do
      content_tag(:span, "Hello World!")
    end
  end
end
