# frozen_string_literal: true

class CombinedControlStories < ViewComponent::Storybook::Stories

  control :greeting, as: :text, default: "Hi", only: :combined_text
  control :name, as: :text, default: "Sarah", only: :combined_text

  def combined_text(greeting: "Hi!", name: "Sarah")
    render Demo::ButtonComponent.new(button_text: "#{greeting} #{name}")
  end


  control :verb_one, as: :text, default: "Big", only: :combined_rest_args
  control :noun_one, as: :text, default: "Car", only: :combined_rest_args
  control :verb_two, as: :text, default: "Small", only: :combined_rest_args
  control :noun_tow, as: :text, default: "Boat", only: :combined_rest_args

  def combined_rest_args(verb_one: "Big", noun_one: "Car", verb_two: "Small", noun_two: "Boat")
    render ArgsComponent.new("#{verb_one} #{noun_one}", "#{verb_two} #{noun_two}")
  end


  control :greeting, as: :text, default: "DO NOT PUSH!", description: "Make this irresistible.", only: :described_control

  def described_control(button_text:'DO NOT PUSH!' )
    render Demo::ButtonComponent.new(button_text: button_text)
  end
end
