# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Collections
      module ValidForStoryConcern
        extend ActiveSupport::Concern

        def valid_for_story?(story_name, only:, except:)
          (only.nil? || Array.wrap(only).include?(story_name)) && Array.wrap(except).exclude?(story_name)
        end
      end
    end
  end
end
