# frozen_string_literal: true

class SlotableV2Stories < ViewComponent::Storybook::Stories
  story :default, SlotsV2Component do
    constructor(
      classes: text("mt-4")
    )

    title.content("This is my title!")

    subtitle.content(
      text("This is my subtitle!")
    )

    tab do
      "Tab A"
    end

    tab.content(text("Tab B"))

    item.content("Item A")

    item(highlighted: boolean(true)) do
      "Item B"
    end

    item.content(text("Item C"))

    item do |i|
      i.subslot { tag.h3("Subslot") }
      tag.p "Item D"
    end

    footer(classes: text("text-blue")) do
      "This is the footer"
    end
  end
end
