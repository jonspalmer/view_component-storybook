---
layout: default
title: Configuration
---

# Configuration

## Stories Path

Story classes live in `test/components/stories`, which can be configured using the `stories_path` setting. For example to use RSpec set the following configuration:

```ruby
# config/application.rb
config.view_component_storybook.stories_path = Rails.root.join("spec/components/stories")
```

## Configuring Asset Hosts

Storybook typically runs on a different port or url from the Rails application. To use Javascript, CSS or other assets served by the Rails application in ViewComponents configure `asset_hosts`
apporpriately. For local development this is often as a simple as adding to `config/development.rb`:

```ruby
# config/development.rb
config.action_controller.asset_host =  'http://localhost:3000'
```

Equivalent configuration is necessary in `config/production.rb` or `config/application.rb` based on the deployment environments.