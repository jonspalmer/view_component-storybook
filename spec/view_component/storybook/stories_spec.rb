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
        addons: ["knobs"],
        stories: [
          {
            name: :jane_doe,
            parameters: {
              server: { id: "kitchen_sink_component/jane_doe" }
            },
            knobs: [
              { name: "Name", param: :name, type: :text, value: "Jane Doe" },
              { name: "Birthday", param: :birthday, type: :date, value: Time.utc(1950, 3, 26).iso8601 },
              { name: "Favorite Color", param: :favorite_color, type: :color, value: "red" },
              { name: "Like People", param: :like_people, type: :boolean, value: true },
              { name: "Number Pets", param: :number_pets, type: :number, value: 2 },
              { name: "Sports", param: :sports, separator: ",", type: :array, value: %w[football baseball] },
              {
                name: "Favorite Food",
                param: :favorite_food,
                type: :select,
                value: "Ice Cream",
                options: { burgers: "Burgers", hot_dog: "Hot Dog", ice_cream: "Ice Cream", pizza: "Pizza" },
              },
              {
                name: "Mood",
                param: :mood,
                type: :radios,
                value: "Happy",
                options: { happy: "Happy", sad: "Sad", angry: "Angry", content: "Content" },
              },
              { name: "Other Things", param: :other_things, type: :object, value: { eyes: "Blue", hair: "Brown" } }
            ]
          }
        ]
      )
    end

    it "converts Stories with namespaces" do
      expect(Demo::ButtonComponentStories.to_csf_params).to eq(
        title: "Demo/Button Component",
        addons: ["knobs"],
        stories: [
          {
            name: :short_button,
            parameters: {
              server: { id: "demo/button_component/short_button" }
            },
            knobs: [
              { name: "Button Text", param: :button_text, type: :text, value: "OK" }
            ]
          },
          {
            name: :medium_button,
            parameters: {
              server: { id: "demo/button_component/medium_button" }
            },
            knobs: [
              { name: "Button Text", param: :button_text, type: :text, value: "Push Me!" }
            ]
          },
          {
            name: :long_button,
            parameters: {
              server: { id: "demo/button_component/long_button" }
            },
            knobs: [
              { name: "Button Text", param: :button_text, type: :text, value: "Really Really Long Button Text" }
            ]
          }
        ]
      )
    end

    it "converts Stories with parameters" do
      expect(ParametersStories.to_csf_params).to eq(
        title: "Parameters",
        addons: ["knobs"],
        parameters: { size: :small },
        stories: [
          {
            name: :stories_parameters,
            parameters: {
              server: { id: "parameters/stories_parameters" }
            },
            knobs: [
              { name: "Button Text", param: :button_text, type: :text, value: "OK" },
            ]
          },
          {
            name: :stories_parameter_override,
            parameters: {
              server: { id: "parameters/stories_parameter_override" },
              size: :large,
              color: :red,
            },
            knobs: [
              { name: "Button Text", param: :button_text, type: :text, value: "OK" }
            ]
          },
          {
            name: :additional_parameters,
            parameters: {
              server: { id: "parameters/additional_parameters" },
              color: :red,
            },
            knobs: [
              { name: "Button Text", param: :button_text, type: :text, value: "OK" }
            ]
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
