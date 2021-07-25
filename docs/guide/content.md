---
layout: default
title: Content
parent: Writing ViewComponent Stories
nav_order: 5
---

# Content

ViewComponents support content passed as a block to their constructor. See ViewComponent [documentation](https://viewcomponent.org/guide/getting-started.html#implementation) for full details.

Stories provide this feature via a block passed to the `constructor` method:

```ruby
# app/components/example_component.rb
class ExampleComponent < ViewComponent::Base
  def initialize(title:)
    @title = title
  end
end
```
```erb
<%# app/components/example_component.html.erb %>
<span title="<%= @title %>"><%= content %></span>
```
```ruby
# test/components/stories/example_component_stories.rb
class ExampleComponentStories < ViewComponent::Storybook::Stories
  story :hellp do
    constructor(title: "my title") do
      "Hello World!"
    end
  end
end
```

Returning the rendered html to Storybook:

```html
<span title="my title">Hello, World!</span>
```

## Content View Helpers

The `constructor` block is evaluated in the context of the view allowing view helpers 
when generating the content. For example:

```ruby
# test/components/stories/example_component_stories.rb
class ExampleComponentStories < ViewComponent::Storybook::Stories
  story :hello_link do
    constructor(title: "my title") do
      link_to "Hello World!", "#"
    end
  end
end
```

Returning the rendered html to Storybook:

```html
<span title="my title"><a href="#">Hello, World!</a></span>
```

## #content

In addition to passing content as a block to `constructor` ViewComponent Storybook accepts content with `with_content`. Content is passed as a string value or a block that supports view helpers. 

```ruby
# test/components/stories/example_component_stories.rb
class ExampleComponentStories < ViewComponent::Storybook::Stories
  story :hello_content do
    constructor(title: "my title")
    content("Hello World!")
  end

  story :hello_content_block do
    constructor(title: "my title")
    content do 
      "Hello World!"
    end
  end

  story :hello_content_block_link do
    constructor(title: "my title")
    content do 
      link_to "Hello World!", "#"
    end
  end
end
```

## Dynamic content with Controls

Passing a Control to `content` enables dynamic rendering of the content in Storybook:

```ruby
# test/components/stories/example_component_stories.rb
class ExampleComponentStories < ViewComponent::Storybook::Stories
  story :hello_content do
    constructor(title: "my title")
    content(text("Hello World!"))
  end
end
```

### Content control naming

By default the Storybook control will have the name "Content". Like all controls The name is customized with [`name`](controls.md#customizing-the-control-name):

```ruby
# test/components/stories/example_component_stories.rb
class ExampleComponentStories < ViewComponent::Storybook::Stories
  story :hello_content do
    constructor(title: "my title")
    content(text("Hello World!").name("Message"))
  end
end
```
