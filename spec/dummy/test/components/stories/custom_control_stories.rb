# frozen_string_literal: true

class CustomControlStories < ViewComponent::Storybook::Stories
  story :custom_text, Demo::ButtonComponent do
    custom_control = custom(greeting: text("Hi"), name: text("Sarah")) do |greeting:, name:|
      "#{greeting} #{name}"
    end
    constructor(
      button_text: custom_control
    )
  end

  story :custom_rest_args, ArgsComponent do
    custom_control_one = custom(verb: text("Big"), noun: text("Car")) do |verb:, noun:|
      "#{verb} #{noun}"
    end
    custom_control_two = custom(verb: text("Small"), noun: text("Boat")) do |verb:, noun:|
      "#{verb} #{noun}"
    end
    constructor(
      custom_control_one,
      custom_control_two
    )
  end

  story :nested_custom_controls, Demo::ButtonComponent do
    name_control = custom(first_name: text("Sarah"), last_name: text("Connor")) do |first_name:, last_name:|
      "#{first_name} #{last_name}"
    end
    custom_control = custom(greeting: text("Hi"), name: name_control) do |greeting:, name:|
      "#{greeting} #{name}"
    end
    constructor(
      button_text: custom_control
    )
  end

  story :described_control, Demo::ButtonComponent do
    constructor(
      button_text: text('DO NOT PUSH!').description('Make this irresistible.')
    )
  end
end
