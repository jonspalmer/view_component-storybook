# frozen_string_literal: true

RSpec.describe ViewComponent::Storybook::Stories do
  describe ".to_csf_params" do
    it "converts" do
      expect(ContentComponentStories.to_csf_params).to eq(
        title: "Content Component",
        stories: [
          {
            name: :with_string_content,
            parameters: {
              server: { id: "content_component/with_string_content" }
            }
          },
          {
            name: :with_control_content,
            parameters: {
              server: { id: "content_component/with_control_content" }
            },
            args: {
              content: "Hello World!"
            },
            argTypes: {
              content: { control: { type: :text }, name: "Content" }
            }
          },
          {
            name: :with_described_control,
            parameters: {
              server: { id: "content_component/with_described_control" }
            },
            args: {
              content: "Hello World!"
            },
            argTypes: {
              content: { control: { type: :text }, description: "My first computer program.", name: "Content" }
            }
          },

          {
            name: :with_helper_content,
            parameters: {
              server: { id: "content_component/with_helper_content" }
            }
          },
        ]
      )
    end

    it "converts kwargs" do
      expect(KwargsComponentStories.to_csf_params).to eq(
        title: "Kwargs Component",
        stories: [
          {
            name: :default,
            parameters: {
              server: { id: "kwargs_component/default" }
            },
            args: {
              message: "Hello World!",
              param: 1,
              other_param: true,
            },
            argTypes: {
              message: { control: { type: :text }, name: "Message" },
              param: { control: { type: :number }, name: "Param" },
              other_param: { control: { type: :boolean }, name: "Other Param" },
            }
          },
          {
            name: :fixed_args,
            parameters: {
              server: { id: "kwargs_component/fixed_args" }
            },
            args: {
              message: "Hello World!"
            },
            argTypes: {
              message: { control: { type: :text }, name: "Message" }
            }
          },
          {
            name: :custom_param,
            parameters: {
              server: { id: "kwargs_component/custom_param" }
            },
            args: {
              my_message: "Hello World!",
              param: 1,
            },
            argTypes: {
              my_message: { control: { type: :text }, name: "My Message" },
              param: { control: { type: :number }, name: "Param" },
            }
          }
        ]
      )
    end

    it "converts args" do
      expect(ArgsComponentStories.to_csf_params).to eq(
        title: "Args Component",
        stories: [
          {
            name: :default,
            parameters: {
              server: { id: "args_component/default" }
            },
            args: {
              items0: "Hello World!",
              items1: "How you doing?",
            },
            argTypes: {
              items0: { control: { type: :text }, name: "Items0" },
              items1: { control: { type: :text }, name: "Items1" },
            }
          },
          {
            name: :fixed_args,
            parameters: {
              server: { id: "args_component/fixed_args" }
            },
            args: {
              items0: "Hello World!"
            },
            argTypes: {
              items0: { control: { type: :text }, name: "Items0" }
            }
          },
          {
            name: :custom_param,
            parameters: {
              server: { id: "args_component/custom_param" }
            },
            args: {
              message: "Hello World!",
              items1: "How you doing?",
            },
            argTypes: {
              message: { control: { type: :text }, name: "Message" },
              items1: { control: { type: :text }, name: "Items1" },
            }
          }
        ]
      )
    end

    it "converts mixed args" do
      expect(MixedArgsComponentStories.to_csf_params).to eq(
        title: "Mixed Args Component",
        stories: [
          {
            name: :default,
            parameters: {
              server: { id: "mixed_args_component/default" }
            },
            args: {
              title: "Hello World!",
              message: "How you doing?",
            },
            argTypes: {
              title: { control: { type: :text }, name: "Title" },
              message: { control: { type: :text }, name: "Message" },
            }
          },
          {
            name: :fixed_args,
            parameters: {
              server: { id: "mixed_args_component/fixed_args" }
            }
          }
        ]
      )
    end

    it "converts kitchen sink" do
      expect(KitchenSinkComponentStories.to_csf_params).to eq(
        title: "Kitchen Sink Component",
        stories: [
          {
            name: :jane_doe,
            parameters: {
              server: { id: "kitchen_sink_component/jane_doe" }
            },
            args: {
              name: "Jane Doe",
              birthday: Time.utc(1950, 3, 26).iso8601,
              favorite_color: "red",
              like_people: true,
              number_pets: 2,
              sports: %w[football baseball],
              favorite_food: "Ice Cream",
              mood: :happy,
              other_things: { eyes: "Blue", hair: "Brown" }

            },
            argTypes: {
              name: { control: { type: :text }, name: "Name" },
              birthday: { control: { type: :date }, name: "Birthday" },
              favorite_color: { control: { type: :color }, name: "Favorite Color" },
              like_people: { control: { type: :boolean }, name: "Like People" },
              number_pets: { control: { type: :number }, name: "Number Pets" },
              sports: { control: { type: :object }, name: "Sports" },
              favorite_food: {
                control: {
                  type: :select,
                },
                name: "Favorite Food",
                options: ["Burgers", "Hot Dog", "Ice Cream", "Pizza"]
              },
              mood: {
                control: {
                  type: :radio,
                  labels: { happy: "Happy", sad: "Sad", angry: "Angry", content: "Content" },
                },
                name: "Mood",
                options: [:happy, :sad, :angry, :content]
              },
              other_things: { control: { type: :object }, name: "Other Things" },
            }
          }
        ]
      )
    end

    it "converts Stories with namespaces" do
      expect(Demo::ButtonComponentStories.to_csf_params).to eq(
        title: "Demo/Button Component",
        stories: [
          {
            name: :short_button,
            parameters: {
              server: { id: "demo/button_component/short_button" }
            },
            args: {
              button_text: "OK"
            },
            argTypes: {
              button_text: { control: { type: :text }, name: "Button Text" }
            }
          },
          {
            name: :medium_button,
            parameters: {
              server: { id: "demo/button_component/medium_button" }
            },
            args: {
              button_text: "Push Me!"
            },
            argTypes: {
              button_text: { control: { type: :text }, name: "Button Text" }
            }
          },
          {
            name: :long_button,
            parameters: {
              server: { id: "demo/button_component/long_button" }
            },
            args: {
              button_text: "Really Really Long Button Text"
            },
            argTypes: {
              button_text: { control: { type: :text }, name: "Button Text" }
            }
          }
        ]
      )
    end

    context "with a custom story title defined" do
      it "converts Stories" do
        expect(Demo::HeadingComponentStories.to_csf_params).to eq(
          title: "Heading Component",
          stories: [
            {
              name: :default,
              parameters: {
                server: { id: "demo/heading_component/default" }
              },
              args: {
                heading_text: "Heading"
              },
              argTypes: {
                heading_text: { control: { type: :text }, name: "Heading Text" }
              }
            }
          ]
        )
      end
    end

    context "with a custom story title generator defined" do
      let(:custom_story_title) { "CustomStoryTitle" }
      let(:component_class) do
        Class.new(described_class) do
          class << self
            def name
              "Demo::MoreButtonComponentStories"
            end
          end
        end
      end

      around do |example|
        original_generator = ViewComponent::Storybook.stories_title_generator
        ViewComponent::Storybook.stories_title_generator = ->(_stories) { custom_story_title }
        example.run
        ViewComponent::Storybook.stories_title_generator = original_generator
      end

      before do
        # stories_title_generator is triggered when a class is declared.
        # To test this behavior we have to create a new class dynamically onew we've
        # configured the stories_title_generator in the around block above

        stub_const("Demo::MoreButtonComponentStories", component_class)
      end

      it "converts Stories" do
        expect(Demo::MoreButtonComponentStories.to_csf_params).to eq(
          title: custom_story_title,
          stories: []
        )
      end

      it "allows compoents to override the title" do
        expect(Demo::HeadingComponentStories.to_csf_params[:title]).to eq("Heading Component")
      end
    end

    xit "converts Stories with parameters" do
      expect(ParametersStories.to_csf_params).to eq(
        title: "Parameters",
        parameters: { size: :small },
        stories: [
          {
            name: :stories_parameters,
            parameters: {
              server: { id: "parameters/stories_parameters" }
            },
            args: {
              button_text: "OK"
            },
            argTypes: {
              button_text: { control: { type: :text }, name: "Button Text" }
            }
          },
          {
            name: :stories_parameter_override,
            parameters: {
              server: { id: "parameters/stories_parameter_override" },
              size: :large,
              color: :red,
            },
            args: {
              button_text: "OK"
            },
            argTypes: {
              button_text: { control: { type: :text }, name: "Button Text" }
            }
          },
          {
            name: :additional_parameters,
            parameters: {
              server: { id: "parameters/additional_parameters" },
              color: :red,
            },
            args: {
              button_text: "OK"
            },
            argTypes: {
              button_text: { control: { type: :text }, name: "Button Text" }
            }
          }
        ]
      )
    end

    it "converts Stories with combined controls" do
      expect(CombinedControlStories.to_csf_params).to eq(
        title: "Combined Control",
        stories: [
          {
            name: :combined_text,
            parameters: {
              server: { id: "combined_control/combined_text" }
            },
            args: {
              greeting: "Hi",
              name: "Sarah"
            },
            argTypes: {
              greeting: { control: { type: :text }, name: "Greeting" },
              name: { control: { type: :text }, name: "Name" }
            }
          },
          {
            name: :combined_rest_args,
            parameters: {
              server: { id: "combined_control/combined_rest_args" }
            },
            args: {
              verb_one: "Big",
              noun_one: "Car",
              verb_two: "Small",
              noun_two: "Boat",
            },
            argTypes: {
              verb_one: { control: { type: :text }, name: "Verb One" },
              noun_one: { control: { type: :text }, name: "Noun One" },
              verb_two: { control: { type: :text }, name: "Verb Two" },
              noun_two: { control: { type: :text }, name: "Noun Two" }
            }
          },
          {
            name: :described_control,
            args: {
              button_text: "DO NOT PUSH!"
            },
            argTypes: {
              button_text: { control: { type: :text }, description: "Make this irresistible.", name: "Button Text" }
            },
            parameters: {
              server: { id: "combined_control/described_control" }
            }
          }
        ]
      )
    end

    it "converts Stories with slots" do
      expect(SlotsStories.to_csf_params).to eq(
        title: "Slots",
        stories: [
          {
            name: :default,
            parameters: {
              server: { id: "slots/default" }
            },
            args: {
              classes: "mt-4",
              title: "This is my title!",
              subtitle: "This is my subtitle!",
              tab2: "Tab B",
              item2_highlighted: true,
              item3: "Item C",
              footer_classes: "text-blue"
            },
            argTypes: {
              classes: { control: { type: :text }, name: "Classes" },
              title: { control: { type: :text }, name: "Title" },
              subtitle: { control: { type: :text }, name: "Subtitle" },
              tab2: { control: { type: :text }, name: "Tab2" },
              item2_highlighted: { control: { type: :boolean }, name: "Item2 Highlighted" },
              item3: { control: { type: :text }, name: "Item3" },
              footer_classes: { control: { type: :text }, name: "Footer Classes" }
            }
          }
        ]
      )
    end
  end

  describe ".write_csf_json" do
    subject { ContentComponentStories.write_csf_json }

    after do
      File.delete(subject)
    end

    it "writes file" do
      expect(subject).to eq(Rails.root.join("test/components/stories/content_component_stories.stories.json").to_s)
      expect(File.exist?(subject)).to be(true)
    end

    it "writes stories to json files" do
      json_file = File.read(subject)
      expect(json_file).to eq(
        <<~JSON.strip
          {
            "title": "Content Component",
            "stories": [
              {
                "name": "with_string_content",
                "parameters": {
                  "server": {
                    "id": "content_component/with_string_content"
                  }
                }
              },
              {
                "name": "with_control_content",
                "parameters": {
                  "server": {
                    "id": "content_component/with_control_content"
                  }
                },
                "args": {
                  "content": "Hello World!"
                },
                "argTypes": {
                  "content": {
                    "control": {
                      "type": "text"
                    },
                    "name": "Content"
                  }
                }
              },
              {
                "name": "with_described_control",
                "parameters": {
                  "server": {
                    "id": "content_component/with_described_control"
                  }
                },
                "args": {
                  "content": "Hello World!"
                },
                "argTypes": {
                  "content": {
                    "control": {
                      "type": "text"
                    },
                    "name": "Content",
                    "description": "My first computer program."
                  }
                }
              },
              {
                "name": "with_helper_content",
                "parameters": {
                  "server": {
                    "id": "content_component/with_helper_content"
                  }
                }
              }
            ]
          }
        JSON
      )
    end
  end
end
