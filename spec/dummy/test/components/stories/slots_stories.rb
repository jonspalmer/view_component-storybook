# frozen_string_literal: true

class SlotsStories < ViewComponent::Storybook::Stories
  control :classes, as: :text
  control :title, as: :text
  control :subtitle, as: :text
  control :tab2, as: :text
  control :item2_highlighted, as: :boolean
  control :item3, as: :text
  control :footer_classes, as: :text

  def default(classes: "mt-4", title: "This is my title!", subtitle: "This is my subtitle!", tab2: "Tab B", item2_highlighted: true, item3: "Item C", footer_classes: "text-blue")
    render SlotsComponent.new(classes: classes) do |c|
      c.with_title { title }
      c.with_subtitle { subtitle }

      c.with_tab { "Tab A" }
      c.with_tab { tab2 }

      c.with_item { "Item A" }
      c.with_item(highlighted: item2_highlighted) { "Item B" }
      c.with_item { item3 }

      c.with_footer(classes: footer_classes) { "This is the footer" }
    end
  end
end
