# frozen_string_literal: true

require "rails/application_controller"

module ViewComponent
  module Storybook
    class StoriesController < Rails::ApplicationController
      prepend_view_path File.expand_path("../../../views", __dir__)
      prepend_view_path Rails.root.join("app/views") if defined?(Rails.root)

      before_action :find_story_configs, :find_story_config, only: :show
      before_action :require_local!, unless: :show_stories?

      content_security_policy(false) if respond_to?(:content_security_policy)

      def show
        params_hash = params.permit!.to_h

        @story = @story_config.story(params_hash)

        layout = @story.layout

        render layout: layout unless layout.nil?
      end

      private

      def show_stories?
        ViewComponent::Storybook.show_stories
      end

      def find_story_configs
        stories_name = params[:stories]
        @story_configs = ViewComponent::Storybook::Stories.find_story_configs(stories_name)

        head :not_found unless @story_configs
      end

      def find_story_config
        story_name = params[:story]
        @story_config = @story_configs.find_story_config(story_name)
        head :not_found unless @story_config
      end
    end
  end
end
