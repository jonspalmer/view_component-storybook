# frozen_string_literal: true

class KwargsComponentStories < ViewComponent::Storybook::Stories
  control :message, as: :text, default: "Hello World!", only: :default
  control :param, as: :number, default: 1, only: :default
  control :other_param, as: :boolean, default: true, only: :default

  def default(message: "Hello World!", param: 1, other_param: true)
    render KwargsComponent.new(message: message, param: param, other_param: other_param)
  end

  control :message, as: :text, default: "Hello World!", only: :fixed_args
  def fixed_args(message: "Hello World!")
    render KwargsComponent.new(message: message, param: 1, other_param: true)
  end

  control :my_message, as: :text, default: "Hello World!", only: :custom_param
  control :param, as: :number, default: 1, only: :custom_param

  def custom_param(my_message: "Hello World!", param: 1)
    render KwargsComponent.new(message: my_message, param: param)
  end
end
