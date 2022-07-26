---
layout: default
title: Controls
parent: Writing ViewComponent Stories
nav_order: 4
---

# Controls

Controls define Storybook [controls](https://storybook.js.org/docs/react/essentials/controls) that enable dynamic rendering of story content. They can be used are arguments to Story [constructors](constructor.md), [content](content.md) or [slots](slots.md).

## Boolean Controls

### boolean(default_value)

Render a boolean control as a checkbox input

```ruby
boolean(true)
```

## Number Controls

### number(default_value, min: nil, max: nil, step: nil)
Render a number control as a numeric text box input:
```ruby
number(5)
```
Supports `min`, `max`, and `step` arguments that restrict the allowed values:
```ruby
number(5, min: 0, max: 100, step 5)
```

### range(default_value, min: nil, max: nil, step: nil)
Render a number control as a range slider input:
```ruby
range(5, min: 0, max: 100, step 5)
```

## Text Controls

### color(default_value, preset_colors: nil)

Render a color control as a color picker input that assumes strings are color values:

```ruby
color("red")
color("ff0000")
color("rgba(255, 0, 0, 1")
```

Supports preset_colors that define a list of color options:
```ruby
color("red", preset_colors, ["green", "yellow", "blue"])
```

### date(default_value)

Render a date control as a date picker input:
```ruby
date(Date.today)
```

### text(default_value)

Render a text control as a simple text input:
```ruby
text("Welcome")
```

## Object Controls

### object(default_value)

Render a hash control as a json text editor:
```ruby
object(title: "Welcome", message: "How are you?")
```

### array(default_value)

Render an array control as a json text editor:
```ruby
array(["Football", "Baseball", "Basketball", "Hockey"])
```

## Enum Controls

### select(options, default_value, labels: nil)
Render an enum control as a select dropdown input:
```ruby
select([:small, :medium, :large, :xlarge], :small)
```
Supports labels:
```ruby
select(
  [:small, :medium, :large, :xlarge],
  :small
  labels: {
    small: "Small",
    medium: "Medium",
    large: "Large",
    xlarge: "X-Large"
  }
)
```


### multi_select(options, default_value, labels: nil)
Render an enum control as a multi-select dropdown input:
```ruby
select([:small, :medium, :large, :xlarge], [:small, :large])
```
Supports labels see [select](#selectoptions-default_value-labels-nil)

### radio(options, default_value, labels: nil)
Render an enum control as a radio button inputs:
```ruby
radio([:small, :medium, :large, :xlarge], :small)
```
Supports labels see [select](#selectoptions-default_value-labels-nil)

### inline_radio(options, default_value, labels: nil)
Render an enum control as a inline radio button inputs:
```ruby
inline_radio([:small, :medium, :large, :xlarge], :small)
```
Supports labels see [select](#selectoptions-default_value-labels-nil)

### check(options, default_value, labels: nil)
Render an enum control as a multi-select checkbox inputs:
```ruby
check([:small, :medium, :large, :xlarge], [:small, :large])
```
Supports labels see [select](#selectoptions-default_value-labels-nil)

### inline_check(options, default_value, labels: nil)
Render an enum control as a multi-select checkbox inputs:
```ruby
inline_check([:small, :medium, :large, :xlarge], [:small, :large])
```
Supports labels see [select](#selectoptions-default_value-labels-nil)

## Custom Controls

Custom controls enable composition of controls to build arguments for a constructor, content or slot

```ruby
# test/components/stories/button_component_stories.rb
class ButtonComponentStories < ViewComponent::Storybook::Stories
  story :simple_button do
    button_text = custom(greeting: text("Hi"), name: text("Sarah")) do |greeting:, name:|
      "#{greeting} #{name}"
    end
    constructor(
      button_text: button_text
    )
  end
end
```

This generates two Storybook text controls, `greeting` and `name`. The block is called with their values and the result, by default `"Hi Sarah"`, is passed as the `button_text` argument to the component's constructor.

## Klazz Controls

Storybook controls support primitive object type - strings, dates, numbers etc. It is common for ViewComponents to take domain models are arguments. The `klazz` control provides a convenient shortcut to building those objects
by composing one or more primitive controls:

```ruby
# app/models/author.rb
class Author
  def initialize(first_name:, last_name:)
    @first_name = first_name
    @last_name = last_name
  end
end
```
```ruby
# app/components/book_component.rb
class BookComponent < ViewComponent::Base
  def initialize(author)
    @author = author
  end
end
```

```ruby
# test/components/stories/book_component_stories.rb
class BookComponentStories < ViewComponent::Storybook::Stories
  story :book do
    constructor(
      author: klazz(Author, first_name: "J.R.R.", last_name: "Tolkien")
    )
  end
end
```

This generates two Storybook text controls, `first_name` and `last_name`. An `Author` model is constructed from their values and passed as the `author` aurgument to the `BookComponent` constructor.

## Customizing the Control Name

By default the name of the control in Storybook is derived from the name of the positional or keyword argument.
For example this story results in two controls with names "First Name" and "Last Name"

```ruby
# test/components/stories/person_componeont_stories.rb
class PersonComponentStories < ViewComponent::Storybook::Stories
  story :person do
    constructor(
      first_name: text("Nelson"),
      last_name:  text("Mandela")
    )
  end
end
```

The control name is configured using `name`:

```ruby
# test/components/stories/person_componeont_stories.rb
class PersonComponentStories < ViewComponent::Storybook::Stories
  story :person do
    constructor(
      first_name: text("Nelson").name("First"),
      last_name:  text("Mandela").name("Last")
    )
  end
end
```

## Adding a description to the control

You can provide additional information about the control by passing a string
into the `description` method.

```ruby
# test/components/stories/person_component_stories.rb
class PersonComponentStories < ViewComponent::Storybook::Stories
  story :person do
    constructor(
      first_name: text("Nelson").description("The person's first name"),
      last_name:  text("Mandela").description("The person's last name")
    )
  end
end
```

To have Storybook.js display your description you will need to add the following
to `.storybook/preview.js`:

```js
export const parameters = {
  controls: { expanded: true }
}
```
