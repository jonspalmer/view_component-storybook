---
layout: default
title: Configuration
---

# Configuration

## Application Url

The Rails application url that Storybook calls for story html is configured in `.storybook/preview.js`.
FOr local development this is typically:

```javascript
// .storybook/preview.js
export const parameters = {
  server: {
    url: `http://localhost:3000/rails/stories`,
  },
};
```

Other environements, such as production, require equivalent configuration.

## Stories Path

Story classes live in `test/components/stories`, which can be configured using the `stories_path` setting. For example to use RSpec set the following configuration:

```ruby
# config/application.rb
config.view_component_storybook.stories_path = Rails.root.join("spec/components/stories")
```

## Stories Route

Stories are served from <http://localhost:3000/rails/stories> by default. To use a different endpoint, set the `stroies_route` option:

```ruby
# config/application.rb
config.view_component_storybook.stroies_route = "/stories"
```

This example will make the previews available from <http://localhost:3000/stories>.

## Configuring Asset Hosts

Storybook typically runs on a different port or url from the Rails application. To use Javascript, CSS or other assets served by the Rails application in ViewComponents configure `asset_hosts`
apporpriately. For local development this is often as a simple as adding to `config/development.rb`:

```ruby
# config/development.rb
config.action_controller.asset_host =  'http://localhost:3000'
```

Equivalent configuration is necessary in `config/production.rb` or `config/application.rb` based on the deployment environments.