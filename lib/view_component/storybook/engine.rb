# frozen_string_literal: true

require "view_component"
require "action_cable/engine"
require "yard"

module ViewComponent
  module Storybook
    class Engine < Rails::Engine
      config.view_component_storybook = ActiveSupport::OrderedOptions.new
      config.view_component_storybook.stories_paths ||= []

      initializer "view_component_storybook.set_configs" do |app|
        options = app.config.view_component_storybook

        options.show_stories = Rails.env.development? if options.show_stories.nil?
        options.stories_route ||= "/rails/stories"

        if options.show_stories && (defined?(Rails.root) && Rails.root.join("test/components/stories").exist?)
          options.stories_paths << Rails.root.join("test/components/stories").to_s

        end

        options.stories_title_generator ||= ViewComponent::Storybook.stories_title_generator

        ActiveSupport.on_load(:view_component_storybook) do
          options.each { |k, v| send("#{k}=", v) }
        end
      end

      initializer "view_component_storybook.set_autoload_paths" do |app|
        options = app.config.view_component_storybook

        if options.show_stories && !options.stories_paths.empty?
          paths_to_add = options.stories_paths - ActiveSupport::Dependencies.autoload_paths
          ActiveSupport::Dependencies.autoload_paths.concat(paths_to_add) if paths_to_add.any?
        end
      end

      initializer "view_component_storybook.parser.stories_load_callback" do
        parser.after_parse do |code_objects|
          Engine.stories.load(code_objects.all(:class))
        end
      end

      config.after_initialize do
        parser.parse
      end

      rake_tasks do
        load File.join(__dir__, "tasks/view_component_storybook.rake")
      end

      def parser
        @parser ||= StoriesParser.new(ViewComponent::Storybook.stories_paths)
      end

      class << self
        def stories
          @stories ||= StoriesCollection.new
        end
      end
    end
  end
end

# :nocov:
unless defined?(ViewComponent::Storybook::Stories)
  ActiveSupport::Deprecation.warn(
    "This manually engine loading is deprecated and will be removed in v1.0.0. " \
    "Remove `require \"view_component/storybook/engine\"`."
  )

  require "view_component/storybook"
end
# :nocov:
