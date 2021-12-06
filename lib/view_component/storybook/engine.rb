# frozen_string_literal: true

require "rails"
require "view_component/storybook"

module ViewComponent
  module Storybook
    class Engine < Rails::Engine
      config.view_component_storybook = ActiveSupport::OrderedOptions.new

      initializer "view_component_storybook.set_configs" do |app|
        options = app.config.view_component_storybook

        options.show_stories = Rails.env.development? if options.show_stories.nil?
        options.stories_route ||= ViewComponent::Storybook.stories_route

        if options.show_stories
          options.stories_path ||= defined?(Rails.root) ? Rails.root.join("test/components/stories") : nil
        end

        options.stories_title_generator ||= ViewComponent::Storybook.stories_title_generator

        ActiveSupport.on_load(:view_component_storybook) do
          options.each { |k, v| send("#{k}=", v) }
        end
      end

      initializer "view_component.set_autoload_paths" do |app|
        options = app.config.view_component_storybook

        ActiveSupport::Dependencies.autoload_paths << options.stories_path if options.show_stories && options.stories_path
      end

      config.after_initialize do |app|
        options = app.config.view_component_storybook

        if options.show_stories
          app.routes.prepend do
            get "#{options.stories_route}/*stories/:story" => "view_component/storybook/stories#show", :internal => true
          end
        end
      end

      rake_tasks do
        load File.join(__dir__, "tasks/write_stories_json.rake")
      end
    end
  end
end
