---
layout: default
title: Slots
parent: Writing ViewComponent Stories
nav_order: 6
---

# Slots

ViewComponent Storybook fully supports ViewComponent's [Slots API](https://viewcomponent.org/guide/slots.html). The Stories API is identical for simple slots, component slots or lamba slots. Consider the component slot example

```ruby
# app/components/blog_component.rb
class BlogComponent < ViewComponent::Base
  renders_one :header, HeaderComponent

  renders_many :posts, PostComponent
end
```

Stories declare slots by callling the method name matching the component's slot passing the arguments for the slot instance and an optional content block that supports view helpers:

```ruby
# test/components/stories/blog_component_stories.rb
class BlogComponentStories < ViewComponent::Storybook::Stories
  story :posts do
    header(classes: "") do
      link_to "My blog", root_path
    end

    post(title: "My blog post") do
      Really interesting stuff.
    end

    post(title: "Another post!") do 
      Blog every day.
    end
  end
end
```

## Dynamic Slots with Controls

Like components dynamic slots are configured by passing control arguements. Slot content with controls is 
configured via `content`:

```ruby
# test/components/stories/blog_component_stories.rb
class BlogComponentStories < ViewComponent::Storybook::Stories
  story :posts do
    header(classes: text("")) do
      link_to "My blog", root_path
    end

    post(title: text("My blog post")) do
      Really interesting stuff.
    end

    post(title: text("Another post!")) do
      Blog every day.
    end
  end
end
```

Results in three `text` controls are rendered in Storybook: "Header  Classes", "Post1  Title",
and "Post2  Title".

## Dynamic Slot content with Controls

Like components slots accept content as controls via `content`:

```ruby
# test/components/stories/blog_component_stories.rb
class BlogComponentStories < ViewComponent::Storybook::Stories
  story :posts do
    header(classes: text("")) do
      link_to "My blog", root_path
    end

    post(title: text("My blog post"))
      .content(text("Really interesting stuff."))

    post(title: text("Another post!"))
      .content(text("Blog every day."))
  end
end
```

Results in five `text` controls are rendered in Storybook: "Header  Classes", "Post1  Title", "Post1  Content"
"Post2  Title", "Post2  Content".

## Rendering Slot Collections

Render [slot collections](https://viewcomponent.org/guide/slots.html#rendering-collections) with dynamic content with an [array](controls.html#arraydefault_value) or [custom](controls.html#custom-controls) control:

```ruby
# app/components/navigation_component.rb
class NavigationComponent < ViewComponent::Base
  renders_many :links, "LinkComponent"

  class LinkComponent < ViewComponent::Base
    def initialize(name:, href:)
      @name = name
      @href = href
    end
  end
end
```

```ruby
# test/components/stories/navigation_component_stories.rb
class NavigationComponentStories < ViewComponent::Storybook::Stories
  story :nav do
    links(
      array(
        [
          { name: "Home", href: "/" },
          { name: "Pricing", href: "/pricing" },
          { name: "Sign Up", href: "/sign-up" },
        ]
      )
    )
  end
end
```
