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
    url: `http://localhost:3000/rails/view_components`,
  },
};
```

Other environments, such as production, require equivalent configuration.

## Stories Path

Story classes live in `test/components/stories`, which can be configured using the `stories_paths` setting. For example to use RSpec set the following configuration:

```ruby
# config/application.rb
config.view_component_storybook.stories_paths << Rails.root.join("spec/components/stories")
```

## Stories Route

Stories are served from the same route as ViewComponent previews <http://localhost:3000/rails/view_components> by default. To use a different endpoint, set the ViewComponent `previews_route` option:

```ruby
# config/application.rb
config.view_component.preview_route = "/stories"
```

This example will make the previews available from <http://localhost:3000/stories>.

For more details see the [ViewComponent `preview_route` documentation](https://viewcomponent.org/api.html#preview_route--string)

## Stories Title Generation

You may wish to customize how the title of stories are generated, this can be done by setting a custom `stories_title_generator` lambda function:

```ruby
# config/application.rb
config.view_component_storybook.stories_title_generator = lambda { |stories|
  stories.stories_name.humanize.delete_prefix('Namespace/').titlecase
}
```

This example will result in a title of `Example Component` instead of `Namespace/Example Component` for a stories file located at `namespace/example_component_stories.rb` (in your stories directory).

## Configuring Asset Hosts

Storybook typically runs on a different port or url from the Rails application. To use Javascript, CSS or other assets served by the Rails application in ViewComponents configure `asset_hosts`
apporpriately. For local development this is often as a simple as adding to `config/development.rb`:

```ruby
# config/development.rb
config.action_controller.asset_host =  'http://localhost:3000'
```

Equivalent configuration is necessary in `config/production.rb` or `config/application.rb` based on the deployment environments.
