# frozen_string_literal: true

require "rails/application_controller"

module ViewComponent
  module Storybook
    class StoriesController < Rails::ApplicationController
      prepend_view_path File.expand_path("../../../views", __dir__)
      prepend_view_path Rails.root.join("app/views") if defined?(Rails.root)

      before_action :find_stories, :find_story, only: :show
      before_action :require_local!, unless: :show_stories?
      before_action :add_wildcard_cors_header, only: :show

      content_security_policy(false) if respond_to?(:content_security_policy)

      def show
        component_args = @story.values_from_params(params.permit!.to_h)

        @content_block = @story.content_block

        @component = @story.component.new(**component_args)

        layout = @story.layout
        render layout: layout unless layout.nil?
      end

      private

      def show_stories?
        ViewComponent::Storybook.show_stories
      end

      def find_stories
        stories_name = params[:stories]
        @stories = ViewComponent::Storybook::Stories.find_stories(stories_name)

        head :not_found unless @stories
      end

      def find_story
        story_name = params[:story]
        @story = @stories.find_story(story_name)
        head :not_found unless @story
      end

      def add_wildcard_cors_header
        headers['Access-Control-Allow-Origin'] = '*'
      end
    end
  end
end
