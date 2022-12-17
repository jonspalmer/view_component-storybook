
module ViewComponent
  module Storybook
    module Controls
      class ControlsCollection
        attr_reader :controls_by_story, :story_default_values

        def initialize(story_methods)
          @controls_by_story = story_methods.map {|method| [method.name, {}]}.to_h

          class_string = File.read(story_methods.first.source_location[0])
          # code_object = YARD.parse_string(class_string)
          # # puts "code_object: #{code_object}"
          # # puts "code_object.meths: #{code_object.meths}"
          # puts "YARD::Registry.all: #{YARD::Registry.all(:class)}"

          # parsed = Parser::CurrentRuby.parse(class_string)
          # p "Parser: #{parsed}"
          # p parsed.methods

          story_methods.each do |method|
            puts "method.source_location: #{method.source_location}"
            source_location = method.source_location
            # File.readlines(source_location[0].each {|line| puts line}
            puts "method def: #{File.readlines(source_location[0])[source_location[1]-1]}"
          end
        end
      end
    end
  end
end