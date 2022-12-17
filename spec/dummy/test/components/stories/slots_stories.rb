# frozen_string_literal: true

class SlotsStories < ViewComponent::Storybook::StoriesV2

  control :classes, as: :text, default: "mt-4"
  control :title, as: :text, default: "This is my title!"
  control :subtitle, as: :text, default: "This is my subtitle!"
  control :tab2, as: :text, default: "Tab B"
  control :item2_highlighted, as: :boolean, default: true
  control :item3, as: :text, default: "Item C"
  control :footer_classes, as: :text, default: "text-blue"

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
