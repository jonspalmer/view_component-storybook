---
layout: default
title: Controls
parent: Writing ViewComponent Stories
nav_order: 4
---

# Controls

## All control types

```ruby
class ButtonComponentStories < ViewComponent::Storybook::Stories
  story(:default) do
    constructor do
      button_text: text('Push Me Please!'),
      disabled: boolean(false),
      width_in_percent: number(min: 0, max: 100, step: 1),
      width_in_percent: range(min: 0, max: 100, step: 1),
      background_color: color(preset_colors: ["#8CDED0", "#F7F6F7", "#83B8FE"]),
      additional_attributes: object({ "aria-label": "Button label"}),
      size: select([:sm, :md, :base, :lg], :base),
      variants: multi_select([:rounded, :striped, :primary, :secondary], [:primary, :rounded]),
      size: radio([:sm, :md, :base, :lg], :base),
      size: inline_radio([:sm, :md, :base, :lg], :base),
      variants: check([:rounded, :striped, :primary, :secondary], [:primary, :rounded]),
      variants: inline_check([:rounded, :striped, :primary, :secondary], [:primary, :rounded]),
      variants: array("rounded, striped, primary, secondary", ","),
      expiration_date: date(Date.today)
    end
  end
end
```


## Custom control types

```ruby
class ButtonComponentStories < ViewComponent::Storybook::Stories
  story(:default) do
    button_text = custom(greeting: text("Hi"), name: text("Sarah")) do |greeting:, name:|
      "#{greeting} #{name}"
    end
    constructor(
      button_text: button_text
    )
  end
end
```

