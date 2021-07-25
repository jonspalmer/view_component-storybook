# frozen_string_literal: true

require "active_model"
require "active_support/dependencies/autoload"

module ViewComponent
  module Storybook
    extend ActiveSupport::Autoload

    autoload :Controls
    autoload :Stories
    autoload :StoryConfig
    autoload :Story
    autoload :Slots
    autoload :ContentConcern
    autoload :MethodArgs
    autoload :Dsl

    include ActiveSupport::Configurable
    # Set the location of component previews through app configuration:
    #
    #     config.view_component_storybook.stories_path = Rails.root.join("lib/component_stories")
    #
    mattr_accessor :stories_path, instance_writer: false

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
    mattr_accessor :stories_route, instance_writer: false do
      "/rails/stories"
    end

    ActiveSupport.run_load_hooks(:view_component_storybook, self)
  end
end
