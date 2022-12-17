# frozen_string_literal: true

class ArgsComponentStories < ViewComponent::Storybook::Stories

  control :items0, as: :text, default: "Hello World!", only: :default
  control :items1, as: :text, default: "How you doing?", only: :default

  def default(items0: "Hello World!", items1: "How you doing?")
    render ArgsComponent.new(items0, items1)
  end


  control :items0, as: :text, default: "Hello World!", only: :fixed_args

  def fixed_args(items0: "Hello World!")
    render ArgsComponent.new(items0, "How you doing?")
  end

  control :message, as: :text, default: "Hello World!", only: :custom_param
  control :items1, as: :text, default: "How you doing?", only: :custom_param

  def custom_param(message: "Hello World!", items1: "How you doing?")
    render ArgsComponent.new(message, items1)
  end
end
