---
layout: default
title: Controls
parent: Writing ViewComponent Stories
nav_order: 3
---

# Controls

Controls define Storybook [controls](https://storybook.js.org/docs/react/essentials/controls) that enable dynamic rendering of story content. Control values are passed to the Story method where they can be used to render dynamic content.

## Boolean Controls

### control(param, as: :boolean, default: default_value)

Render a boolean control as a toogle input

```ruby
control :active, as: :boolean, default: true
```

## Number Controls

### control(param, as: :number, default: default_value, min: nil, max: nil, step: nil)
Render a number control as a numeric text box input:
```ruby
control :count, as: :number, default: 5
```
Supports `min`, `max`, and `step` arguments that restrict the allowed values:
```ruby
control :actcountive, as: :number, default: 5, min: 0, max: 100, step 5
```

### control(param, as: :range, default: default_value, min: nil, max: nil, step: nil)
Render a number control as a range slider input:
```ruby
control :count, as: :range, default: 5, min: 0, max: 100, step 5
```

## Text Controls

### control(param, as: :color, default: default_value, preset_colors: nil)

Render a color control as a color picker input that assumes strings are color values:

```ruby
control :favorite, as: :color, default: "red"
control :favorite, as: :color, default: "ff0000"
control :actfavoriteive, as: :color, default: "rgba(255, 0, 0, 1)"
```

Supports preset_colors that define a list of color options:
```ruby
control :favorite, as: :color, default: "red", preset_colors, ["green", "yellow", "blue"]
```

### control(param, as: :date, default: default_value

Render a date control as a date picker input:
```ruby
control :created, as: :date, default: Date.today
```

### control(param, as: :text, default: default_value

Render a text control as a simple text input:
```ruby
control :message, as: :date, default: "Welcome"
```

## Object Controls

### control(param, as: :object, default: default_value

Render a hash control as a json text editor:
```ruby
control :greeting, as: :object, default: {title: "Welcome", message: "How are you?"}
```

Render an array control as a json text editor:
```ruby
control :sports, as: :object, default: ["Football", "Baseball", "Basketball", "Hockey"]
```

## Enum Controls

### control(param, as: :select, default: default_value, options: options, labels: nil)
Render an enum control as a select dropdown input:
```ruby
control :size, as: :select, default: :small, options: [:small, :medium, :large, :xlarge] 
```
Supports labels:
```ruby
control( 
  :size, 
  as: :select, 
  default: :small,
  options: [:small, :medium, :large, :xlarge],
  labels: {
    small: "Small",
    medium: "Medium",
    large: "Large",
    xlarge: "X-Large"
  }
)
```

### control(param, as: :multo_select, default: default_value, options: options, labels: nil)
Render an enum control as a multi-select dropdown input:
```ruby
control :size, as: :select, default: [:small, :large], options: [:small, :medium, :large, :xlarge] 
```
Supports labels see [select](#selectoptions-default_value-labels-nil)

### control(param, as: :radio, default: default_value, options: options, labels: nil)
Render an enum control as a radio button inputs:
```ruby
control :size, as: :radio, default: :small, options: [:small, :medium, :large, :xlarge] 
```
Supports labels see [select](#selectoptions-default_value-labels-nil)

### control(param, as: :inline_radio, default: default_value, options: options, labels: nil)
Render an enum control as a inline radio button inputs:
```ruby
control :size, as: :inline_radio, default: :small, options: [:small, :medium, :large, :xlarge] 
```
Supports labels see [select](#selectoptions-default_value-labels-nil)

### control(param, as: :check, default: default_value, options: options, labels: nil)
Render an enum control as a multi-select checkbox inputs:
```ruby
control :size, as: :check, default: [:small, :large], options: [:small, :medium, :large, :xlarge]
```
Supports labels see [select](#selectoptions-default_value-labels-nil)

### control(param, as: :inline_check, default: default_value, options: options, labels: nil)
Render an enum control as a multi-select checkbox inputs:
```ruby
control :size, as: :inine_check, default: [:small, :large], options: [:small, :medium, :large, :xlarge]
```
Supports labels see [select](#selectoptions-default_value-labels-nil)

## Control Default Values

The default value for a control is read from the default value of the story method.

For example, in the following stories the default value of the content control will be `Hellow World!` and `Goodby...` for the respetive stories.

```ruby
# test/components/stories/message_component_stories.rb
class MessageComponentStories < ViewComponent::Storybook::Stories
  control :content, as: :text

  def hello_world(content: "Hello World!")
    render MessageComponent.new do
      content
    end 
  end

    def goodbye(content: "Goodbye...")
    render MessageComponent.new do
      content
    end 
  end
end
```

The default can also be set via the `default` parameter when declaring the control.

```ruby
# test/components/stories/message_component_stories.rb
class MessageComponentStories < ViewComponent::Storybook::Stories
  control :content, as: :text, default: "Hello World!"

  def hello_world(content: )
    render MessageComponent.new do
      content
    end 
  end
end
```  

## Restricting Controls to certain stories

By default control is declared for all story methods. This is convinient when different stories only differ in their default values.

```ruby
# test/components/stories/header_component_stories.rb
class HeaderComponentStories < ViewComponent::Storybook::Stories
  control :tag, as: :text

  def h1(tag: "h1")
    render HeaderComponent.new(tag)
  end

  def h2(tag: "h2")
    render HeaderComponent.new(tag)
  end
end
```

However, controls can be declared to apply to `only` a particualr story:

```ruby
# test/components/stories/header_component_stories.rb
class HeaderComponentStories < ViewComponent::Storybook::Stories
  control :tag, as: :text

  def h1(tag: "h1")
    render HeaderComponent.new(tag)
  end

  control :content, as: :text, only: :h2
  
  def h2(tag: "h2", content: "Hello World!")
    render HeaderComponent.new(tag) do 
      content
    end
  end
end

## Customizing the Control Name

By default the name of the control in Storybook is derived from the control's parameter.
For example this story results in two controls with names "First Name" and "Last Name"

```ruby
# test/components/stories/person_component_stories.rb
class PersonComponentStories < ViewComponent::Storybook::Stories
  control :first_name, as: :text
  control :last_name, as: :text

  def person(first_name: "Nelson", last_name: "Mandela")
    render PersonComponent.new(first_name: first_name, last_name: last_name)
  end
end
```

The control's name is configured using the `name` parameter:

```ruby
# test/components/stories/person_component_stories.rb
class PersonComponentStories < ViewComponent::Storybook::Stories
  control :first_name, as: :text, name: "First"
  control :last_name, as: :text, name: "Last"

  def person(first_name: "Nelson", last_name: "Mandela")
    render PersonComponent.new(first_name: first_name, last_name: last_name)
  end
end
```

## Adding a description to the control

You can provide additional information about the control by adding a `description` option.

```ruby
# test/components/stories/person_component_stories.rb
class PersonComponentStories < ViewComponent::Storybook::Stories
  control :first_name, as: :text, name: "First", description: "The person's first name"
  control :last_name, as: :text, name: "Last", description: "The person's last name"

  def person(first_name: "Nelson", last_name: "Mandela")
    render PersonComponent.new(first_name: first_name, last_name: last_name)
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
