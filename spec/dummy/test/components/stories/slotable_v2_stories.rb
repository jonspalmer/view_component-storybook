# frozen_string_literal: true

class SlotableV2Stories < ViewComponent::Storybook::Stories
  story :default, SlotsV2Component do
    constructor(
      classes: text("mt-4")
    )

    slot(:title).with_content("This is my title!")

    slot(:subtitle).with_content(
      text("This is my subtitle!")
    )

    slot(:tab) do
      "Tab A"
    end

    slot(:tab).with_content(text("Tab B"))

    slot(:item).with_content("Item A")

    slot(:item, highlighted: boolean(true)) do
      "Item B"
    end

    slot(:item).with_content(text("Item C"))

    slot(:footer, classes: text("text-blue")) do
      "This is the footer"
    end
  end
end
