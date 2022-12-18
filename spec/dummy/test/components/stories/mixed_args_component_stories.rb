# frozen_string_literal: true

class MixedArgsComponentStories < ViewComponent::Storybook::Stories
  control :title, as: :text, only: :default
  control :message, as: :text, only: :default

  def default(title: "Hello World!", message: "How you doing?")
    render MixedArgsComponent.new(title, message: message)
  end

  def fixed_args
    render MixedArgsComponent.new("Hello World!", message: "How you doing?")
  end
end
