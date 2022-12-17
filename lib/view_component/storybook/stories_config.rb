# frozen_string_literal: true

module ViewComponent
  module Storybook
    class StoriesConfig
      delegate :title, :parameters, :stories_name, to: :stories_class
      attr_reader :stories_class, :stories_json_path

      def initialize(code_object)
        @code_object = code_object
        @stories_class = code_object.path.constantize

        dir = File.dirname(@code_object.file)
        json_filename = code_object.path.demodulize.underscore

        @stories_json_path = File.join(dir, "#{json_filename}.stories.json")

        @stories_class.stories_config = self
      end

      # def story_configs
      #   @story_configs =
      # end

      def to_csf_params
        csf_params = { title: title }
        csf_params[:parameters] = parameters if parameters.present?
        csf_params[:stories] = story_configs.map(&:to_csf_params)
        csf_params
      end

      def write_csf_json
        # json_path = File.join(stories_path, "#{stories_name}.stories.json")
        File.write(stories_json_path, JSON.pretty_generate(to_csf_params))
        stories_json_path
      end

      def story_configs
        @story_configs ||= begin
          public_methods = stories_class.public_instance_methods(false)
          method_objects = @code_object.meths.select { |m| public_methods.include?(m.name) }
          method_objects.map { |code_object| StoryV2.from_code_object(code_object, self) }
        end
      end

      # # Returns +true+ if the stories exist.
      # def stories_exists?(stories_name)
      #   all.any? { |stories| stories.stories_name == stories_name }
      # end

      # # Find a component stories by its underscored class name.
      # def find_story_configs(stories_name)
      #   all.find { |stories| stories.stories_name == stories_name }
      # end

      # # Returns +true+ if the story of the component stories exists.
      # def story_exists?(name)
      #   story_configs.map(&:name).include?(name.to_sym)
      # end

      # # find the story by name
      # def find_story_config(name)
      #   story_configs.find { |config| config.name == name.to_sym }
      # end
    end
  end
end
