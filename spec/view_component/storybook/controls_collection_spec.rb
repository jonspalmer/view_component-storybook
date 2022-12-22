# frozen_string_literal: true

RSpec.describe ViewComponent::Storybook::ControlsCollection do
  subject do
    collection = described_class.new
    # borromw the code_object from Demo::ButtonComponentStories as an example
    collection.code_object = Demo::ButtonComponentStories.code_object
    collection
  end

  let(:short_controls) { subject.for_story(:short_button) }
  let(:medium_controls) { subject.for_story(:medium_button) }
  let(:long_controls) { subject.for_story(:long_button) }

  describe "control builders" do
    it "builds text controls" do
      subject.add :name, as: :text, default: "Jane Doe"

      expect(short_controls.first).to have_attributes(
        class: ViewComponent::Storybook::Controls::Text,
        param: :name,
        default: "Jane Doe"
      )
    end

    it "builds boolean controls" do
      subject.add :active, as: :boolean, default: true

      expect(short_controls.first).to have_attributes(
        class: ViewComponent::Storybook::Controls::Boolean,
        param: :active,
        default: true
      )
    end

    it "builds number controls with minimal args" do
      subject.add :count, as: :number, default: 2

      expect(short_controls.first).to have_attributes(
        class: ViewComponent::Storybook::Controls::Number,
        param: :count,
        type: :number,
        default: 2,
        min: nil,
        max: nil,
        step: nil
      )
    end

    it "builds number controls with all args" do
      subject.add :count, as: :number, default: 2, min: 0, max: 10, step: 1

      expect(short_controls.first).to have_attributes(
        class: ViewComponent::Storybook::Controls::Number,
        param: :count,
        type: :number,
        default: 2,
        min: 0,
        max: 10,
        step: 1
      )
    end

    it "builds #range controls with minimal args" do
      subject.add :count, as: :range, default: 2

      expect(short_controls.first).to have_attributes(
        class: ViewComponent::Storybook::Controls::Number,
        param: :count,
        type: :range,
        default: 2,
        min: nil,
        max: nil,
        step: nil
      )
    end

    it "builds range controls with all args" do
      subject.add :count, as: :range, default: 2, min: 0, max: 10, step: 1

      expect(short_controls.first).to have_attributes(
        class: ViewComponent::Storybook::Controls::Number,
        param: :count,
        type: :range,
        default: 2,
        min: 0,
        max: 10,
        step: 1
      )
    end

    it "builds color controls" do
      subject.add :favorite, as: :color, default: "red"

      expect(short_controls.first).to have_attributes(
        class: ViewComponent::Storybook::Controls::Color,
        param: :favorite,
        default: "red"
      )
    end

    it "builds object controls" do
      subject.add :description, as: :object, default: { hair: "Brown", eyes: "Blue" }

      expect(short_controls.first).to have_attributes(
        class: ViewComponent::Storybook::Controls::Object,
        param: :description,
        default: { hair: "Brown", eyes: "Blue" }
      )
    end

    %w[select radio inline-radio].each do |type|
      control_type = type.underscore

      it "builds #{control_type} single option controls" do
        subject.add :food, as: control_type.to_sym, options: [:hot_dog, :pizza], default: :pizza

        expect(short_controls.first).to have_attributes(
          class: ViewComponent::Storybook::Controls::Options,
          param: :food,
          type: type.to_sym,
          default: :pizza,
          options: [:hot_dog, :pizza]
        )
      end
    end

    %w[multi-select check inline-check].each do |type|
      control_type = type.underscore

      it "builds #{control_type} multi-option controls" do
        subject.add :food, as: control_type.to_sym, options: [:hot_dog, :pizza], default: :pizza

        expect(short_controls.first).to have_attributes(
          class: ViewComponent::Storybook::Controls::MultiOptions,
          param: :food,
          type: type.to_sym,
          default: [:pizza],
          options: [:hot_dog, :pizza]
        )
      end
    end
  end

  describe "control defaults" do
    it "reads default value from method params" do
      subject.add :button_text, as: :text

      expect(short_controls.first.default).to eq("OK")
      expect(medium_controls.first.default).to eq("Push Me!")
      expect(long_controls.first.default).to eq("Really Really Long Button Text")
    end

    it "uses default from add methods over value from method params" do
      subject.add :button_text, as: :text, default: "Hi"

      expect(short_controls.first.default).to eq("Hi")
      expect(medium_controls.first.default).to eq("Hi")
      expect(long_controls.first.default).to eq("Hi")
    end

    it "uses default from add methods over value from method params when restricted to only methods" do
      subject.add :button_text, as: :text
      subject.add :button_text, as: :text, default: "Hi", only: :short_button

      expect(short_controls.first.default).to eq("Hi")
      expect(medium_controls.first.default).to eq("Push Me!")
      expect(long_controls.first.default).to eq("Really Really Long Button Text")
    end
  end

  describe "control restrictions" do
    it "restricts only: story_name" do
      subject.add :button_text, as: :text, default: "Hi", only: :short_button

      expect(short_controls.first).to have_attributes(
        class: ViewComponent::Storybook::Controls::Text,
        param: :button_text,
        default: "Hi"
      )
      expect(medium_controls).to be_empty
    end

    it "overwrites control declaration" do
      subject.add :button_text, as: :text, default: "Hi"
      subject.add :button_text, as: :color, default: "Bye"

      expect(short_controls.first).to have_attributes(
        class: ViewComponent::Storybook::Controls::Color,
        param: :button_text,
        default: "Bye"
      )
    end

    it "overwrites control declaration for only: story_name" do
      subject.add :button_text, as: :text, default: "Hi"
      subject.add :button_text, as: :color, default: "Red", only: :medium_button

      expect(short_controls.first).to have_attributes(
        class: ViewComponent::Storybook::Controls::Text,
        param: :button_text,
        default: "Hi"
      )

      expect(medium_controls.first).to have_attributes(
        class: ViewComponent::Storybook::Controls::Color,
        param: :button_text,
        default: "Red"
      )
    end

    it "overwrites control declaration for only: Array(*story_names)" do
      subject.add :button_text, as: :text, default: "Hi"
      subject.add :button_text, as: :color, default: "Red", only: [:medium_button, :long_button]

      expect(short_controls.first).to have_attributes(
        class: ViewComponent::Storybook::Controls::Text,
        param: :button_text,
        default: "Hi"
      )

      expect(medium_controls.first).to have_attributes(
        class: ViewComponent::Storybook::Controls::Color,
        param: :button_text,
        default: "Red"
      )

      expect(long_controls.first).to have_attributes(
        class: ViewComponent::Storybook::Controls::Color,
        param: :button_text,
        default: "Red"
      )
    end

    it "ignored for empty only array" do
      subject.add :button_text, as: :text, default: "Hi", only: []

      expect(short_controls).to be_empty
      expect(medium_controls).to be_empty
      expect(long_controls).to be_empty
    end

    it "overwrites control declaration for except: story_name" do
      subject.add :button_text, as: :text, default: "Hi"
      subject.add :button_text, as: :color, default: "Red", except: :medium_button

      expect(short_controls.first).to have_attributes(
        class: ViewComponent::Storybook::Controls::Color,
        param: :button_text,
        default: "Red"
      )

      expect(medium_controls.first).to have_attributes(
        class: ViewComponent::Storybook::Controls::Text,
        param: :button_text,
        default: "Hi"
      )

      expect(long_controls.first).to have_attributes(
        class: ViewComponent::Storybook::Controls::Color,
        param: :button_text,
        default: "Red"
      )
    end

    it "overwrites control declaration for except: Array(*story_names)" do
      subject.add :button_text, as: :text, default: "Hi"
      subject.add :button_text, as: :color, default: "Red", except: [:medium_button, :long_button]

      expect(short_controls.first).to have_attributes(
        class: ViewComponent::Storybook::Controls::Color,
        param: :button_text,
        default: "Red"
      )

      expect(medium_controls.first).to have_attributes(
        class: ViewComponent::Storybook::Controls::Text,
        param: :button_text,
        default: "Hi"
      )

      expect(long_controls.first).to have_attributes(
        class: ViewComponent::Storybook::Controls::Text,
        param: :button_text,
        default: "Hi"
      )
    end
  end
end
