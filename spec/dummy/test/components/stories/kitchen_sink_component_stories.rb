# frozen_string_literal: true

class KitchenSinkComponentStories < ViewComponent::Storybook::Stories
  # story :jane_doe, KitchenSinkComponent do
  #   constructor(
  #     name: text("Jane Doe"),
  #     birthday: date(Date.new(1950, 3, 26)),
  #     favorite_color: color("red"),
  #     like_people: boolean(true),
  #     number_pets: number(2),
  #     sports: array(%w[football baseball]),
  #     favorite_food: select(["Burgers", "Hot Dog", "Ice Cream", "Pizza"], "Ice Cream"),
  #     mood: radio(
  #       [:happy, :sad, :angry, :content],
  #       :happy,
  #       labels: { happy: "Happy", sad: "Sad", angry: "Angry", content: "Content" }
  #     ),
  #     other_things: object({ hair: "Brown", eyes: "Blue" })
  #   )
  # end

  # controls do
  #   text(:name, "Jane Doe")
  #   date(:birthday, Date.new(1950, 3, 26))
  #   color(:favorite_color, "red")
  #   boolean(:like_people, true)
  #   number(:number_pets, 2)
  #   array(:sports, %w[football baseball])
  #   select(:favorite_food, ["Burgers", "Hot Dog", "Ice Cream", "Pizza"], "Ice Cream")
  #   radio(:mood, [:happy, :sad, :angry, :content],
  #           :happy,
  #           labels: { happy: "Happy", sad: "Sad", angry: "Angry", content: "Content" })
  #   object(:other_things, { hair: "Brown", eyes: "Blue" })
  # end

  control :name, as: :text, default: "Jane Doe"
  control :birthday, as: :date, default: Date.new(1950, 3, 26)
  control :favorite_color, as: :color, default: "red"
  control :like_people, as: :boolean, default: true
  control :number_pets, as: :number, default: 2
  control :sports, as: :array, default: %w[football baseball]
  control :favorite_food, as: :select, default: "Ice Cream", options: ["Burgers", "Hot Dog", "Ice Cream", "Pizza"]
  control :mood, as: :radio, default: :happy, options: [:happy, :sad, :angry, :content], labels: { happy: "Happy", sad: "Sad", angry: "Angry", content: "Content" }
  control :other_things, as: :object, default: { hair: "Brown", eyes: "Blue" }

  def jane_doe(
    name: "Jane Doe",
    birthday: Date.new(1950, 3, 26),
    favorite_color: "red",
    like_people: true,
    number_pets: 2,
    sports: %w[football baseball],
    favorite_food: "Ice Cream",
    mood: :happy,
    other_things: { hair: "Brown", eyes: "Blue" }
  )
    render KitchenSinkComponent.new(
      name: name,
      birthday: birthday,
      favorite_color: favorite_color,
      like_people: like_people,
      number_pets: number_pets,
      sports: sports,
      favorite_food: favorite_food,
      mood: mood,
      other_things: other_things
    )
  end
end
