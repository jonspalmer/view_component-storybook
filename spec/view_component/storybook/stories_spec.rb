# frozen_string_literal: true

RSpec.describe ViewComponent::Storybook::Stories do
  describe ".valid?" do
    it "duplicate stories are invalid" do
      expect(Invalid::DuplicateStoryStories.valid?).to eq(false)
      expect(Invalid::DuplicateStoryStories.errors[:story_configs].length).to eq(1)
    end

    it "is invalid if stories are invalid" do
      expect(Invalid::InvalidConstrutorStories.valid?).to eq(false)
      expect(Invalid::InvalidConstrutorStories.errors[:story_configs].length).to eq(1)
    end
  end

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
            name: :with_block_content,
            parameters: {
              server: { id: "content_component/with_block_content" }
            }
          },
          {
            name: :with_helper_content,
            parameters: {
              server: { id: "content_component/with_helper_content" }
            }
          },
          {
            name: :with_constructor_content,
            parameters: {
              server: { id: "content_component/with_constructor_content" }
            }
          }
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

    it "supports legacy controls dsl" do
      expect(LegacyControlsDslStories.to_csf_params).to eq(
        title: "Legacy Controls Dsl",
        stories: [
          {
            name: :short_button,
            parameters: {
              server: { id: "legacy_controls_dsl/short_button" }
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

    context 'with a custom story title defined' do
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

    context 'with a custom story title generator defined' do
      let(:stories_class_name) { 'Demo::ButtonComponentStories' }
      let(:custom_story_title) { 'CustomStoryTitle' }

      before do
        # Creating the class dynamically leaves `name` nil
        allow(described_class).to receive(:name).and_return(stories_class_name)
        # Descendant tracking appends our dynamic class to the list of
        # descendants which (logically) causes failures on the .all example
        # below
        allow(ActiveSupport::DescendantsTracker).to receive(:store_inherited)
        stub_const(stories_class_name, Class.new(described_class))
      end

      around do |example|
        original_generator = ViewComponent::Storybook.stories_title_generator
        ViewComponent::Storybook.stories_title_generator = ->(_stories) { custom_story_title }
        example.run
        ViewComponent::Storybook.stories_title_generator = original_generator
      end

      it "converts Stories" do
        expect(Demo::ButtonComponentStories.to_csf_params).to eq(
          title: custom_story_title,
          stories: []
        )
      end
    end

    it "converts Stories with parameters" do
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

    it "converts Stories with custom controls" do
      expect(CustomControlStories.to_csf_params).to eq(
        title: "Custom Control",
        stories: [
          {
            name: :custom_text,
            parameters: {
              server: { id: "custom_control/custom_text" }
            },
            args: {
              button_text__greeting: "Hi",
              button_text__name: "Sarah"
            },
            argTypes: {
              button_text__greeting: { control: { type: :text }, name: "Button Text  Greeting" },
              button_text__name: { control: { type: :text }, name: "Button Text  Name" }
            }
          },
          {
            name: :custom_rest_args,
            parameters: {
              server: { id: "custom_control/custom_rest_args" }
            },
            args: {
              items0__verb: "Big",
              items0__noun: "Car",
              items1__verb: "Small",
              items1__noun: "Boat",
            },
            argTypes: {
              items0__verb: { control: { type: :text }, name: "Items0  Verb" },
              items0__noun: { control: { type: :text }, name: "Items0  Noun" },
              items1__verb: { control: { type: :text }, name: "Items1  Verb" },
              items1__noun: { control: { type: :text }, name: "Items1  Noun" }
            }
          },
          {
            name: :nested_custom_controls,
            parameters: {
              server: { id: "custom_control/nested_custom_controls" }
            },
            args: {
              button_text__greeting: "Hi",
              button_text__name__first_name: "Sarah",
              button_text__name__last_name: "Connor"
            },
            argTypes: {
              button_text__greeting: { control: { type: :text }, name: "Button Text  Greeting" },
              button_text__name__first_name: { control: { type: :text }, name: "Button Text  Name  First Name" },
              button_text__name__last_name: { control: { type: :text }, name: "Button Text  Name  Last Name" }
            }
          }
        ]
      )
    end

    it "converts Stories with slots" do
      expect(SlotableV2Stories.to_csf_params).to eq(
        title: "Slotable V2",
        stories: [
          {
            name: :default,
            parameters: {
              server: { id: "slotable_v2/default" }
            },
            args: {
              classes: "mt-4",
              subtitle__content: "This is my subtitle!",
              tab2__content: "Tab B",
              item2__highlighted: true,
              item3__content: "Item C",
              footer__classes: "text-blue"
            },
            argTypes: {
              classes: { control: { type: :text }, name: "Classes" },
              subtitle__content: { control: { type: :text }, name: "Subtitle  Content" },
              tab2__content: { control: { type: :text }, name: "Tab2  Content" },
              item2__highlighted: { control: { type: :boolean }, name: "Item2  Highlighted" },
              item3__content: { control: { type: :text }, name: "Item3  Content" },
              footer__classes: { control: { type: :text }, name: "Footer  Classes" }
            }
          }
        ]
      )
    end

    it "raises an excpetion if stories are invalid" do
      expect { Invalid::DuplicateStoryStories.to_csf_params }.to(
        raise_exception(
          ViewComponent::Storybook::Stories::ValidationError,
          "Invalid::DuplicateStoryStories invalid: (Story configs duplicate story name 'my_story')"
        )
      )
    end

    it "raises an excpetion if a story_config is invalid" do
      expect { Invalid::InvalidConstrutorStories.to_csf_params }.to(
        raise_exception(
          ViewComponent::Storybook::Stories::ValidationError,
          "Invalid::InvalidConstrutorStories invalid: (Story configs 'invalid_kwards' is invalid: (Constructor args invalid: (Kwargs 'junk' is invalid)))"
        )
      )
    end
  end

  describe ".write_csf_json" do
    subject { ContentComponentStories.write_csf_json }

    after do
      File.delete(subject)
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
                "name": "with_block_content",
                "parameters": {
                  "server": {
                    "id": "content_component/with_block_content"
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
              },
              {
                "name": "with_constructor_content",
                "parameters": {
                  "server": {
                    "id": "content_component/with_constructor_content"
                  }
                }
              }
            ]
          }
        JSON
      )
    end
  end

  describe ".all" do
    it "has all stories" do
      expect(described_class.all).to eq [
        ArgsComponentStories,
        ContentComponentStories,
        CustomControlStories,
        Demo::ButtonComponentStories,
        Demo::HeadingComponentStories,
        DryComponentStories,
        Invalid::DuplicateStoryStories,
        Invalid::InvalidConstrutorStories,
        KitchenSinkComponentStories,
        KwargsComponentStories,
        LayoutStories,
        LegacyControlsDslStories,
        MixedArgsComponentStories,
        NoLayoutStories,
        ParametersStories,
        SlotableV2Stories
      ]
    end
  end

  describe ".find_story_configs" do
    it "returns the Stories if they exist" do
      expect(described_class.find_story_configs("demo/button_component")).to eq Demo::ButtonComponentStories
    end

    it "returns nil if no stories exists" do
      expect(described_class.find_story_configs("foo/button_component")).to eq nil
    end
  end

  describe ".exists?" do
    it "is true for stories that exist" do
      expect(described_class.stories_exists?("demo/button_component")).to eq true
    end

    it "is false for stories that doesn't exist" do
      expect(described_class.stories_exists?("foo/button_component")).to eq false
    end
  end

  describe ".story_exists?" do
    it "is true for a story that exists" do
      expect(Demo::ButtonComponentStories.story_exists?(:short_button)).to eq true
    end

    it "can be called with a string" do
      expect(Demo::ButtonComponentStories.story_exists?("short_button")).to eq true
    end

    it "is false for a story that dones't exist" do
      expect(Demo::ButtonComponentStories.story_exists?(:foo_button)).to eq false
    end
  end
end
