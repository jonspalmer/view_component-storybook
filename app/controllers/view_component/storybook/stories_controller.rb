# frozen_string_literal: true

require "rails/application_controller"

module ViewComponent
  module Storybook
    class StoriesController < Rails::ApplicationController
      prepend_view_path File.expand_path("../../../views", __dir__)
      prepend_view_path Rails.root.join("app/views") if defined?(Rails.root)

      before_action :find_stories, :find_story, only: :show
      before_action :require_local!, unless: :show_stories?

      content_security_policy(false) if respond_to?(:content_security_policy)

      def show
        params_hash = params.permit!.to_h
        constructor_args = @story.constructor_args(params_hash)
        constructor_kwargs = @story.constructor_kwargs(params_hash)

        @content_block = @story.content_block

        @component = @story.component.new(*constructor_args, **constructor_kwargs)

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
    end
  end
end
