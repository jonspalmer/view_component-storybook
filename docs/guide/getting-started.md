---
layout: default
title: Getting started
parent: Writing ViewComponent Stories
nav_order: 1
---

# Getting started

## Installation

### Rails Installation

1. In `Gemfile`, add:
   ```ruby
   gem "view_component", require: "view_component/engine"
   ```
1. In `config/application.rb`, add: 
   ```ruby
   require "view_component/storybook/engine"
   ```
1. In`.gitignore`, add:
   ```text
   **/*.stories.json
   ```


### Storybook Installation

1. Add Storybook Server as a dev dependedncy. 
   ```console
   yarn add @storybook/server @storybook/addon-controls --dev
   ```
  Storybook Controls addon isn't required but is strongly recommended.

2. Add an NPM script start Storybook. In ``package.json`, add:

   ```json
   {
     "scripts": {
       "storybook": "start-storybook"
     }
   }
   ```

3. Configure Storybook to find the json stories the gem creates. Create `.storybook/main.js`,

   ```javascript
   module.exports = {
     stories: ["../test/components/**/*.stories.json"],
     addons: ["@storybook/addon-controls"],
   };
   ```

4. Configure Storybook with the Rails application url to call for the html content of the stories. Create `.storybook/preview.js`

   ```javascript
   export const parameters = {
     server: {
       url: `http://localhost:3000/rails/stories`,
     },
   };
   ```


## Quick start

### Create a ViewComponent

Use the component [generator](https://viewcomponent.org/guide/generators.html) to create a new ViewComponent.

```console
bin/rails generate component Example title

      invoke  test_unit
      create  test/components/example_component_test.rb
      create  app/components/example_component.rb
      create  app/components/example_component.html.erb
```

This generates a new component:

```ruby
# app/components/example_component.rb
class ExampleComponent < ViewComponent::Base
  def initialize(title:)
    @title = title
  end
end
```

Add a template for the new component: 

```erb
<%# app/components/example_component.html.erb %>
<span title="<%= @title %>"><%= content %></span>
```

### Write a story for ExampleComponent

```ruby
# test/components/stories/example_componeont_stories.rb
class ExampleComponentStories < ViewComponent::Storybook::Stories
  story :hello_world do
    constructor(title: "my title")
    content("Hello World!")
end
```

### Generating Storybook Stories JSON

Generate the Storybook JSON stories by running the rake task:

```sh
rake view_component_storybook:write_stories_json
```

### Start the Rails app and Storybook

In separate shells start the Rails app and Storybook

```console
rails s
```

```console
yarn storybook
```

The second command will open the Storybook app in your browser rendering your ExampleComponent story!
![Hello World]({{ site.baseurl }}/assets/images/hello_world.png)

## Implementation

When Storybook calls the Rails app for the html story content the ViewComponent::Storybook
passes the string "my title" to the component constructor and "Hello World!" as the component content.
Effectively the component is rendered in a view as:

```erb
<%= render(ExampleComponent.new(title: "my title")) do %>
  Hello, World!
<% end %>
```

Returning the rendered html to Storybook:

```html
<span title="my title">Hello, World!</span>
```

## Dynamic Stories with Controls

Storybook isn't just for rendering static stories. Storybook [controls](https://storybook.js.org/docs/react/essentials/controls) enable dynamic stories with variable inputs. ViewComponent Storybook exposes a similar api to describe dynamic inputs to component stories. For example add the `text` control to make `title` and `content` dynamic:

```ruby
# test/components/stories/example_componeont_stories.rb
class ExampleComponentStories < ViewComponent::Storybook::Stories
  story :hello_world  do
    constructor(title: text("my title"))
    content(text("Hello World!"))
end
```

This adds text controls to the Storybook Controls panel. Changing the values re-renders the compoent.
![Hello World Controls]({{ site.baseurl }}/assets/images/hello_world_controls.png) 

Available controls and their options are documented on the [Controls](controls.md) page.
