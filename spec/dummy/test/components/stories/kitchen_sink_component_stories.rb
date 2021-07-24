# frozen_string_literal: true

class KitchenSinkComponentStories < ViewComponent::Storybook::Stories
  story :jane_doe, KitchenSinkComponent do
    constructor(
      name: text("Jane Doe"),
      birthday: date(Date.new(1950, 3, 26)),
      favorite_color: color("red"),
      like_people: boolean(true),
      number_pets: number(2),
      sports: array(%w[football baseball]),
      favorite_food: select(["Burgers", "Hot Dog", "Ice Cream", "Pizza"], "Ice Cream"),
      mood: radio(
        [:happy, :sad, :angry, :content],
        :happy,
        labels: { happy: "Happy", sad: "Sad", angry: "Angry", content: "Content" }
      ),
      other_things: object({ hair: "Brown", eyes: "Blue" })
    )
  end
end
