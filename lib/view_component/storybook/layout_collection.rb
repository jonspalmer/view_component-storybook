# frozen_string_literal: true

module ViewComponent
  module Storybook
    class LayoutCollection
      def initialize
        @default = nil
        @layouts = []
      end

      def add(layout, only: nil, except: nil)
        if only.nil? && except.nil?
          @default = layout
        else
          layouts << { layout: layout, only: only, except: except }
        end
      end

      # Parameters set for the story method
      def for_story(story_name)
        story_layout = default
        layouts.each do |opts|
          story_layout = opts[:layout] if valid_for_story?(story_name, **opts.slice(:only, :except))
        end
        story_layout
      end

      private

      attr_reader :default, :layouts

      def valid_for_story?(story_name, only:, except:)
        (only.nil? || Array.wrap(only).include?(story_name)) && Array.wrap(except).exclude?(story_name)
      end
    end
  end
end
