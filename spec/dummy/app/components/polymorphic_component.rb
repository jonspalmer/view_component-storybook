# frozen_string_literal: true

class PolymorphicComponent < ViewComponent::Base
  include ViewComponent::PolymorphicSlots

  class ItemTypeOneComponent < ViewComponent::Base
    def initialize(text:)
      super
      @text = text
    end
  end

  renders_many :items, types: {
    one: ItemTypeOneComponent,
    two: ->(text:) { tag.div(text, class: 'item-type-two') },
    three: nil
  }
end
