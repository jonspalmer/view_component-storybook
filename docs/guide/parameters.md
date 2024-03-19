---
layout: default
title: Parameters
parent: Writing ViewComponent Stories
nav_order: 5
---

# Parameters

Configure Storybook addons with `parameters`. Global parameters are defined in `.storybook/preview.js` - this is how the Storybook Rails [application url](/configuration.html#application-url). 

Parameters can be defined for all stories with the `parameters` method:


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
```

## Restricting parameters to certain stories 

Parameters specified at the Stories and Story level are merged in that order. the `parameters` method suports `only` and `except` options in the same format as the `controls` method. For example disable the a11y addon for all stories and enable it for one:


```ruby
# test/components/stories/header_component_stories.rb
class HeaderComponentStories < ViewComponent::Storybook::Stories
  # disable a11y for all stories in this class
  parameters(a11y: { disable: true ))

  def h1
    render HeaderComponent.new("h1") do
      "Hello World!"
    end 

  
  parameters(a11y: { disable: false ), only: :h2)
  
  def h2
    render HeaderComponent.new("h2") do
      "How are you?"
    end 
  end
end
```
