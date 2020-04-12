# frozen_string_literal: true

class KitchenSinkComponent < ViewComponent::Base
  attr_reader :name, :birthday, :favorite_color, :like_people, :number_pets, :sports, :favorite_food, :mood, :other_things

  def initialize(
    name:,
    birthday:,
    favorite_color:,
    like_people:,
    number_pets:,
    sports:,
    favorite_food:,
    mood:,
    other_things:
  )
    @name = name
    @birthday = birthday
    @favorite_color = favorite_color
    @like_people = like_people
    @number_pets = number_pets
    @sports = sports
    @favorite_food = favorite_food
    @mood = mood
    @other_things = other_things
  end
end
