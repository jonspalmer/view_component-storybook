# frozen_string_literal: true

Dummy::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # The test environment is used exclusively to run your application's
  # test suite.  You never need to work with it otherwise.  Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs.  Don't rely on the data there!
  config.cache_classes = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment
  config.action_controller.allow_forgery_protection = false

  config.view_component_storybook.show_stories = true

  config.view_component_storybook.stories_title_generator = lambda { |stories|
    # Test a custom story title generator
    if stories.stories_name == "demo/heading_component"
      return stories.stories_name.delete_prefix('demo/').humanize.titlecase
    end

    stories.stories_name.humanize.titlecase
  }

  # Print deprecation notices to the stderr
  config.active_support.deprecation = :stderr

  config.eager_load = true
end
