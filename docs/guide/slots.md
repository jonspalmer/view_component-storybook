---
layout: default
title: Slots
parent: Writing ViewComponent Stories
nav_order: 4
---

# Slots

ViewComponent Storybook fully supports ViewComponent's [Slots API](https://viewcomponent.org/guide/slots.html). The Stories API is identical for simple slots, component slots or lamba slots. Consider the component slot example:

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
  def posts
    render BlogComponent.new do |c|
      c.with_header(classes: "") do 
        link_to "My blog", root_path
      end

      c.with_post(title: "My blog post") { "Really interesting stuff." }

      c.with_post(title: "Another post!") { "Blog every day." } 
    end
  end
end
```

## Dynamic Slots with Controls

Like components dynamic slots are configured by passing control arguements

```ruby
# test/components/stories/blog_component_stories.rb
class BlogComponentStories < ViewComponent::Storybook::Stories
  control :header_classes, as: :text
  control :post_one_title, as: :text
  control :post_one_content, as: :text
  control :post_two_title, as: :text
  control :post_two_content, as: :text

  def posts(
    header_classes: "",
    post_one_title: "My blog post",
    post_one_content: "Really interesting stuff.",
    post_two_title: "Another post!",
    post_two_content: "Blog every day."
  )
    render BlogComponent.new do |c|
      c.with_header(classes: header_classes) do 
        link_to "My blog", root_path
      end

      c.with_post(title: blog_one_title) { post_one_content }

      c.with_post(title: blog_two_title) { post_two_content } 
    end
  end
end
```
