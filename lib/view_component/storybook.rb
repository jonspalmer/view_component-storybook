# frozen_string_literal: true

require "active_model"
require "active_support/dependencies/autoload"
require "view_component/storybook/engine"

module ViewComponent
  module Storybook
    extend ActiveSupport::Autoload

    autoload :Knobs
    autoload :Stories
    autoload :StoryConfig
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

    ActiveSupport.run_load_hooks(:view_component_storybook, self)
  end
end
