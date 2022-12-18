---
layout: default
title: Stories
parent: Writing ViewComponent Stories
nav_order: 2
---

# Stories

Stories are Ruby classes that inherit from `ViewComponent::Storybook::Stories`. Stories are just an extension of [ViewComponent Previews](https://viewcomponent.org/guide/previews.html) Stories can have one or more story defined as public methods:

```ruby
# test/components/stories/header_component_stories.rb
class HeaderComponentStories < ViewComponent::Storybook::Stories
  def h1
    render HeaderComponent.new("h1")
  end

  def h2
    render HeaderComponent.new("h2")
  end
end.
```

## Stories Title

By default the stories title derives from the stories class name. The class `HeaderComponentStories` above will have a title of "Header Component". Configure a custom title with `title`:

```ruby
# test/components/stories/header_component_stories.rb
class HeaderComponentStories < ViewComponent::Storybook::Stories
  title "H1 Headers Stories" 

   def h1
    render HeaderComponent.new("h1")
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

