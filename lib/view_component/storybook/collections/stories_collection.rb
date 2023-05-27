# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Collections
      class StoriesCollection
        include Enumerable

        delegate_missing_to :stories

        attr_reader :stories

        def load(code_objects)
          @stories = Array(code_objects).map { |obj| StoriesCollection.stories_from_code_object(obj) }.compact
        end

        def self.stories_from_code_object(code_object)
          klass = code_object.path.constantize
          return unless stories_class?(klass)

          klass.code_object = code_object
          klass
        end

        def self.stories_class?(klass)
          return unless klass.ancestors.include?(ViewComponent::Storybook::Stories)

          !klass.respond_to?(:abstract_class) || klass.abstract_class != true
        end
      end
    end
  end
end
