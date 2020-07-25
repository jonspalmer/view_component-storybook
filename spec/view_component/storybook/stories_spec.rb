# frozen_string_literal: true

RSpec.describe ViewComponent::Storybook::Stories do
  describe ".to_csf_params" do
    it "converts" do
      expect(ContentComponentStories.to_csf_params).to eq(
        title: "Content Component",
        stories: [
          {
            name: :default,
            parameters: {
              server: { id: "content_component/default" }
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
              mood: "Happy",
              other_things: { eyes: "Blue", hair: "Brown" }

            },
            argTypes: {
              name: { control: { type: :text }, name: "Name" },
              birthday: { control: { type: :date }, name: "Birthday" },
              favorite_color: { control: { type: :color }, name: "Favorite Color" },
              like_people: { control: { type: :boolean }, name: "Like People" },
              number_pets: { control: { type: :number }, name: "Number Pets" },
              sports: { control: { type: :array, separator: "," }, name: "Sports" },
              favorite_food: {
                control: {
                  type: :select,
                  options: { burgers: "Burgers", hot_dog: "Hot Dog", ice_cream: "Ice Cream", pizza: "Pizza" }
                },
                name: "Favorite Food",
              },
              mood: {
                control: {
                  type: :radios,
                  options: { happy: "Happy", sad: "Sad", angry: "Angry", content: "Content" },
                },
                name: "Mood"
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
  end

  describe ".all" do
    it "has all stories" do
      expect(described_class.all).to eq [
        ContentComponentStories,
        Demo::ButtonComponentStories,
        KitchenSinkComponentStories,
        LayoutStories,
        NoLayoutStories,
        ParametersStories
      ]
    end
  end

  describe ".find_stories" do
    it "returns the Stories if they exist" do
      expect(described_class.find_stories("demo/button_component")).to eq Demo::ButtonComponentStories
    end

    it "returns nil if no stories exists" do
      expect(described_class.find_stories("foo/button_component")).to eq nil
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
