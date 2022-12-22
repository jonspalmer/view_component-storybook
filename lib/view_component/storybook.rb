# frozen_string_literal: true

require "active_model"
require "active_support/dependencies/autoload"

module ViewComponent
  module Storybook
    extend ActiveSupport::Autoload

    autoload :Controls
    autoload :Stories
    autoload :StoriesParser
    autoload :StoriesCollection
    autoload :ControlsCollection
    autoload :ParametersCollection
    autoload :Story
    autoload :Slots

    include ActiveSupport::Configurable
    # Set the location of component previews through app configuration:
    #
    #     config.view_component_storybook.stories_path = Rails.root.join("lib/component_stories")
    #
    mattr_accessor :stories_paths, instance_writer: false

    # Enable or disable component previews through app configuration:
    #
    #     config.view_component_storybook.show_stories = true
    #
    # Defaults to +true+ for development environment
    #
    mattr_accessor :show_stories, instance_writer: false

    # Set the entry route for component stories:
    #
    #     config.view_component_storybook.stories_route = "/stories"
    #
    # Defaults to `/rails/stories` when `show_stories` is enabled.
    #
    mattr_accessor :stories_route, instance_writer: false

    # :nocov:
    if defined?(ViewComponent::Storybook::Engine)
      ActiveSupport::Deprecation.warn(
        "This manually engine loading is deprecated and will be removed in v1.0.0. " \
        "Remove `require \"view_component/storybook/engine\"`."
      )
    elsif defined?(Rails::Engine)
      require "view_component/storybook/engine"
    end
    # :nocov:

    # Define how component stories titles are generated:
    #
    #     config.view_component_storybook.stories_title_generator = lambda { |stories|
    #       stories.stories_name.humanize.upcase
    #     }
    #
    mattr_accessor :stories_title_generator, instance_writer: false,
                                             default: ->(stories) { stories.stories_name.humanize.titlecase }

    ActiveSupport.run_load_hooks(:view_component_storybook, self)
  end
end
