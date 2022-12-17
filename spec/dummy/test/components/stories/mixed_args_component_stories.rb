# frozen_string_literal: true

class MixedArgsComponentStories < ViewComponent::Storybook::StoriesV2
  control :title, as: :text, default: "Hello World!", only: :default
  control :message, as: :text, default: "How you doing?", only: :default

  def default(title: "Hello World!", message: "How you doing?")
    render MixedArgsComponent.new(title, message: message)
  end

  def fixed_args()
    render MixedArgsComponent.new("Hello World!", message: "How you doing?")
  end
end
