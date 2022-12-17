module ViewComponent
  module Storybook
    class StoriesCollection

      attr_reader :stories

      def load(code_objects)
        @stories = Array(code_objects).map { |obj| StoriesCollection.stories_config_from_code_object(obj) }.compact
      end

      def self.stories_config_from_code_object(code_object)
        klass = code_object.path.constantize

        ViewComponent::Storybook::StoriesConfig.new(code_object) if stories_class?(klass)
      # rescue => exception
      #   puts exception.to_s
      #   # Lookbook.logger.error exception.to_s
      #   nil
      end
  
      def self.stories_class?(klass)
        if klass.ancestors.include?(ViewComponent::Storybook::Stories)
          !klass.respond_to?(:abstract_class) || klass.abstract_class != true
        end
      end
    end
  end
end
