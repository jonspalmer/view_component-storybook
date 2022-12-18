---
layout: default
title: Parameters
parent: Writing ViewComponent Stories
nav_order: 5
---

# Parameters

Configure Storybook addons with `parameters`. Global parameters are defined in `.storybook/preview.js` - this is how the Storybook Rails [application url](/configuration.html#application-url).


```ruby
# test/components/stories/header_component_stories.rb
class HeaderComponentStories < ViewComponent::Storybook::Stories
  # disable a11y for all stories in this class
  parameters(a11y: { disable: true ))

  def h1
    render HeaderComponent.new("h1") do
      "Hello World!"
    end 
  end
end
```
