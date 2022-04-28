# frozen_string_literal: true

class PolymorphicStories < ViewComponent::Storybook::Stories
  story :default, PolymorphicComponent do
    item_one(text: 'Hello World')

    item_two(text: 'Bonjour monde')

    item_three do
      tag.div('Hàlo a Shaoghail', class: 'item-type-three')
    end
  end
end
