---
layout: default
title: Parameters
parent: Writing ViewComponent Stories
nav_order: 8
---

# Parameters

Configure Storybook addons with `parameters`. Global parameters are defined in `.storybook/preview.js` - this is how the Storybook Rails [application url](/configuration.html#application-url). Parameteters specified at the Stories and Story level are merged in that order. For example disable the a11y addon for all stories and enable it for one:


```ruby
# test/components/stories/header_componeont_stories.rb
class HeaderComponentStories < ViewComponent::Storybook::Stories
  # disable a11y for all stories in this class
  parameters(a11y: { disable: true ))

  story :h1 do
    constructor("h1")
  end

  story :h2 do
    # enable a11y addom for just this story
    parameters(a11y: { disable: false ))

    constructor("h2")
  end
end
```