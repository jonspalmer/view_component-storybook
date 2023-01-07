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

  control :name, as: :text
  control :birthday, as: :date
  control :favorite_color, as: :color
  control :like_people, as: :boolean
  control :number_pets, as: :number
  control :sports, as: :array
  control :favorite_food, as: :select, options: ["Burgers", "Hot Dog", "Ice Cream", "Pizza"]
  control :mood, as: :radio, options: [:happy, :sad, :angry, :content], labels: { happy: "Happy", sad: "Sad", angry: "Angry", content: "Content" }
  control :other_things, as: :object

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
