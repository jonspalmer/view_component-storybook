require "yard"

module ViewComponent
  module Storybook
    class StoriesV2 < ViewComponent::Preview
      include Controls::ControlsHelpers

      class_attribute :stories_parameters, :stories_title, :stories_config

      class << self

        def title(title = nil)
          # if no argument is passed act like a getter
          self.stories_title = title unless title.nil?
          stories_title
        end

        def parameters(params = nil)
          # if no argument is passed act like a getter
          self.stories_parameters = params unless params.nil?
          stories_parameters
        end

        def stories_name
          name.chomp("V2").chomp("Stories").underscore
        end

        def preview_name
          stories_name
        end

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
            story_names.map { |method| StoryV2.new(story_id(method), method, {}, controls_for_story(method)) }
          end
        end

        private

        def inherited(other)
          super(other)
          # setup class defaults
          other.stories_title = Storybook.stories_title_generator.call(other)
        end

        def stories_json_path
          @stories_json_path ||= File.join(File.dirname(__FILE__), "#{File.basename(__FILE__, ".rb")}.stories.json")
        end

        def story_id(name)
          "#{stories_name}/#{name.to_s.parameterize}".underscore
        end

        def story_methods
          @story_methods ||= public_instance_methods(false).map { |name| instance_method(name) }
        end

        def story_names
          @story_names ||= story_methods.map(&:name)
        end

        def controls_for_story(story_name)
          controls.select do |control|
            control.valid_for_story?(story_name)
          end
        end
      end
    end
  end
end