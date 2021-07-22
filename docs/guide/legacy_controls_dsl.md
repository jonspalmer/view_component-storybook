---
nav_exclude: true
---

# Legacy Controls DSL (deprecated)

_Controls DSL is now deprectaed and will be removed in 1.0. Please migrate to [Constructor](constructor.md)_

```ruby
class ButtonComponentStories < ViewComponent::Storybook::Stories
  story(:default) do
    controls do
      text(:button_text, 'Push Me Please!')
      boolean(:disabled, false)
      number(:width_in_percent, min: 0, max: 100, step: 1)
      range(:width_in_percent, min: 0, max: 100, step: 1)
      color(:background_color, preset_colors: ["#8CDED0", "#F7F6F7", "#83B8FE"])
      object(:additional_attributes, { "aria-label": "Button label"})
      select(:size, [:sm, :md, :base, :lg], :base)
      multi_select(:variants, [:rounded, :striped, :primary, :secondary], [:primary, :rounded])
      radio(:size, [:sm, :md, :base, :lg], :base)
      inline_radio(:size, [:sm, :md, :base, :lg], :base)
      check(:variants, [:rounded, :striped, :primary, :secondary], [:primary, :rounded])
      inline_check(:variants, [:rounded, :striped, :primary, :secondary], [:primary, :rounded])
      array(:variants, "rounded, striped, primary, secondary", ",")
      date(:expiration_date, Date.today)
    end
  end
end
```
