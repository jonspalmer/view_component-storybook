# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Collections
      class LayoutCollection
        include Collections::ValidForStoryConcern

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
      end
    end
  end
end
