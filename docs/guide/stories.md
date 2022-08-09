---
layout: default
title: Stories
parent: Writing ViewComponent Stories
nav_order: 2
---

# Stories

Stories are Ruby classes that inherit from `ViewComponent::Storybook::Stories`. Stories can have one or more stories defined with `story(story_name)`:

```ruby
# test/components/stories/header_component_stories.rb
class HeaderComponentStories < ViewComponent::Storybook::Stories
  story :h1 do
    constructor("h1")
  end

  story :h2 do
    constructor("h2")
  end
end.
```

## Stories Title

By default the stories title derives from the stories class name. The class `HeaderComponentStories` above will have a title of "Header Component". Configure a custom title with `title`:

```ruby
# test/components/stories/header_component_stories.rb
class HeaderComponentStories < ViewComponent::Storybook::Stories
  title "H1 Headers Stories" 

  story :h1 do
    constructor("h1")
  end
end
```

## Story Component

By default the story ViewComponent derives from the stories class name. The class `HeaderComponentStories` will
default to `HeaderComponent`. This supports a common convention of grouping all stories for a particular component
together. The second argument to the `story` method configures the component class: 

```ruby
# test/components/stories/header_component_stories.rb
class HeaderComponentStories < ViewComponent::Storybook::Stories
  story :h1 do
    constructor("h1")
  end

  story(:subheader, HeaderSubheaderComponent) do
    constructor("h1", "h2")
  end
end
```

## Layout

Components are rendered in the default application layout. The layout for a set of stories is configured with `layout`:

```ruby
# test/components/stories/header_component_stories.rb
class HeaderComponentStories < ViewComponent::Storybook::Stories
  layout :desktop
  
  story :h1 do
    constructor("h1")
  end
end
```

### Overriding Story Layout

Individual stories can define their own layout that overrides the stories setting:

```ruby
# test/components/stories/header_component_stories.rb
class HeaderComponentStories < ViewComponent::Storybook::Stories
  layout :desktop
  
  story :h1 do
    constructor("h1")
  end

  story :mobile_h1 do
    layout :mobile
    constructor("h1")
  end
end
```

### No Layout 

Setting layout to false renders the component in isolation:

```ruby
# test/components/stories/header_component_stories.rb
class HeaderComponentStories < ViewComponent::Storybook::Stories
  story :no_layout_h1 do
    layout false
    constructor("h1")
  end
end
```

### Default Story Layout

Stories layout is inherited by Stories classes. Create an `AppplicationStories` class to define a default 
stories layout:

```ruby
# test/components/stories/application_stories.rb
class ApplicationStories < ViewComponent::Storybook::Stories
  layout :stories

# test/components/stories/header_component_stories.rb
class HeaderComponentStories < ApplicationStories
  story :h1 do
    constructor("h1")
  end
end
```

