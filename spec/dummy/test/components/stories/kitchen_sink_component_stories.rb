# frozen_string_literal: true

class KitchenSinkComponentStories < ViewComponent::Storybook::Stories
  story :jane_doe, KitchenSinkComponent do
    controls do
      name "Jane Doe"
      birthday Date.new(1950, 3, 26)
      color(:favorite_color, "red")
      like_people true
      number_pets 2
      sports %w[football baseball]
      select(:favorite_food, { hot_dog: "Hot Dog", pizza: "Pizza", burgers: "Burgers", ice_cream: "Ice Cream" }, "Ice Cream")
      radio(:mood, { happy: "Happy", sad: "Sad", angry: "Angry", content: "Content" }, "Happy")
      other_things(hair: "Brown", eyes: "Blue")
    end
  end
end
