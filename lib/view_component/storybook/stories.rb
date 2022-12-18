# frozen_string_literal: true

require "yard"

module ViewComponent
  module Storybook
    class Stories < ViewComponent::Preview
      include Controls::ControlsHelpers

      class_attribute :stories_parameters, :stories_title, :code_object

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
          @stories ||= story_names.map { |method| Story.new(story_id(method), method, {}, controls_for_story(method)) }
        end

        # find the story by name
        def find_story_config(name)
          stories.find { |config| config.name == name.to_sym }
        end

        # Returns the arguments for rendering of the component in its layout
        def render_args(story_name, params: {})
          # mostly reimplementing the super method but adding logic to parse the params through the controls
          story_params_names = instance_method(story_name).parameters.map(&:last)
          provided_params = params.slice(*story_params_names).to_h.symbolize_keys

          story_config = find_story_config(story_name)

          control_parsed_params = provided_params.to_h do |param, value|
            control = story_config.controls.find { |c| c.param == param }
            value = control.parse_param_value(value) if control

            [param, value]
          end

          result = control_parsed_params.empty? ? new.public_send(story_name) : new.public_send(story_name, **control_parsed_params)
          result ||= {}
          result[:template] = preview_example_template_path(story_name) if result[:template].nil?
          @layout = nil unless defined?(@layout)
          result.merge(layout: @layout)
        end

        private

        def inherited(other)
          super(other)
          # setup class defaults
          other.stories_title = Storybook.stories_title_generator.call(other)
        end

        def stories_json_path
          @stories_json_path ||= begin
            dir = File.dirname(code_object.file)
            json_filename = code_object.path.demodulize.underscore

            File.join(dir, "#{json_filename}.stories.json")
          end
        end

        def story_id(name)
          "#{stories_name}/#{name.to_s.parameterize}".underscore
        end

        def story_names
          @story_names ||= begin
            public_methods = public_instance_methods(false)
            if code_object
              # ordering of public_instance_methods isn't consistent
              # use the code_object to sort the methods to the order that they're declared
              code_object.meths.select { |m| public_methods.include?(m.name) }.map(&:name)
            else
              # there is no code_object in some specs, particularly where we create Stories after Yard parsing
              # in these cases just use the names as returned by the public_methods
              public_methods.map(&:name)
            end
          end
        end

        def controls_for_story(story_name)
          code_method = code_object.meths.find { |m| m.name == story_name }

          controls.select do |control|
            control.valid_for_story?(story_name)
          end.map do |control|
            dup_control = control.dup
            unless dup_control.default.present?
              default_value_parts = code_method.parameters.find { |parts| parts[0].chomp(":") == control.param.to_s }
              if default_value_parts
                dup_control.default = code_method.instance_eval(default_value_parts[1])
              end
            end
            dup_control
          end
        end
      end
    end
  end
end
