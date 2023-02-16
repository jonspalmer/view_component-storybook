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
   gem "view_component-storybook"
   ```
2. In`.gitignore`, add:
   ```text
   **/*.stories.json
   ```

### Storybook Installation

1. Add Storybook Server as a dev dependency. 
   ```console
   yarn add @storybook/server @storybook/addon-controls --dev
   ```
  Storybook Controls addon isn't required but is strongly recommended.

2. Add an NPM script to start Storybook. In `package.json`, add:

   ```json
   {
     "scripts": {
       "storybook": "start-storybook"
     }
   }
   ```

3. Configure Storybook to find the json stories that the gem creates. Create `.storybook/main.js`,

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
       url: `http://localhost:3000/rails/view_components`,
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

Stories are ViewComponent Previews with some Storybook magic sprinkled in.

```ruby
# test/components/stories/example_component_stories.rb
class ExampleComponentStories < ViewComponent::Storybook::Stories
  def hello_world
    render ExampleComponent.new(title: "my title") do
      "Hello World!"
    end 
  end
end
```

### Storybook Stories JSON

Generate the Storybook JSON stories by running the rake task:

```sh
rake view_component_storybook:write_stories_json
```

Remove existing Storybook JSON stories by running the rake task:

```sh
rake view_component_storybook:remove_stories_json
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


## Dynamic Stories with Controls

Storybook isn't just for rendering static stories. Storybook [controls](https://storybook.js.org/docs/react/essentials/controls) enable dynamic stories with variable inputs. ViewComponent Storybook exposes a similar api to describe dynamic inputs to component stories. For example add `text` controls to make `title` and `content` dynamic:

```ruby
# test/components/stories/example_component_stories.rb
class ExampleComponentStories < ViewComponent::Storybook::Stories

  control :title, as: :text
  control :content, as: :text
  def hello_world(title: "my title", content: "Hello World!")
    render ExampleComponent.new(title: title) do
      content
    end 
  end
end
```

This adds text controls to the Storybook Controls panel. Changing the values re-renders the component.
![Hello World Controls]({{ site.baseurl }}/assets/images/hello_world_controls.png) 

Available controls and their options are documented on the [Controls](controls.md) page.
