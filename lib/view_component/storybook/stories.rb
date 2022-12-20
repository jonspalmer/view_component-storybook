# frozen_string_literal: true

require "yard"

module ViewComponent
  module Storybook
    class Stories < ViewComponent::Preview
      # include Controls::ControlsHelpers

      class_attribute :stories_parameters, :stories_title, :stories_json_path

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

        def control(param, as:, **opts)
          controls.add(param, as: as, **opts)
        end

        def stories_name
          name.chomp("Stories").underscore
        end

        def preview_name
          stories_name
        end

        def to_csf_params
          csf_params = { title: title }
          csf_params[:parameters] = parameters if parameters.present?
          csf_params[:stories] = stories.map(&:to_csf_params)
          csf_params
        end

        def write_csf_json
          Rails.logger.debug { "stories_json_path: #{stories_json_path}" }
          File.write(stories_json_path, JSON.pretty_generate(to_csf_params))
          stories_json_path
        end

        def stories
          @stories ||= story_names.map { |method| Story.new(story_id(method), method, {}, controls.for_story(method)) }
        end

        # find the story by name
        def find_story(name)
          stories.find { |story| story.name == name.to_sym }
        end

        # Returns the arguments for rendering of the component in its layout
        def render_args(story_name, params: {})
          # mostly reimplementing the super method but adding logic to parse the params through the controls
          story_params_names = instance_method(story_name).parameters.map(&:last)
          provided_params = params.slice(*story_params_names).to_h.symbolize_keys

          story = find_story(story_name)

          control_parsed_params = provided_params.to_h do |param, value|
            control = story.controls.find { |c| c.param == param }
            value = control.parse_param_value(value) if control

            [param, value]
          end

          result = control_parsed_params.empty? ? new.public_send(story_name) : new.public_send(story_name, **control_parsed_params)
          result ||= {}
          result[:template] = preview_example_template_path(story_name) if result[:template].nil?
          @layout = nil unless defined?(@layout)
          result.merge(layout: @layout)
        end

        attr_reader :code_object

        def code_object=(object)
          @code_object = object
          self.stories_json_path ||= begin
            dir = File.dirname(object.file)
            json_filename = object.path.demodulize.underscore

            File.join(dir, "#{json_filename}.stories.json")
          end

          controls.code_object = object

          # ordering of public_instance_methods isn't consistent
          # use the code_object to sort the methods to the order that they're declared
          @story_names = object.meths.select { |m| story_names.include?(m.name) }.map(&:name)
        end

        private

        def inherited(other)
          super(other)
          # setup class defaults
          other.stories_title = Storybook.stories_title_generator.call(other)
        end

        def controls
          @controls ||= ControlsCollection.new
        end

        def story_id(name)
          "#{stories_name}/#{name.to_s.parameterize}".underscore
        end

        def story_names
          @story_names ||= public_instance_methods(false)
        end
      end
    end
  end
end
