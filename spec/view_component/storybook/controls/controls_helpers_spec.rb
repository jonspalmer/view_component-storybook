# frozen_string_literal: true

RSpec.describe ViewComponent::Storybook::Controls::ControlsHelpers do
  include described_class

  subject { controls.first }

  shared_examples "has controls attributes" do |control_attributes|
    it "has expected attributes" do
      expect(subject).to have_attributes(control_attributes)
    end
  end

  describe "#text" do
    control :name, as: :text, default: "Jane Doe"

    include_examples "has controls attributes",
                     {
                       class: ViewComponent::Storybook::Controls::TextConfig,
                       param: :name,
                       default: "Jane Doe"
                     }
  end

  describe "#boolean" do
    control :active, as: :boolean, default: true

    include_examples "has controls attributes",
                     {
                       class: ViewComponent::Storybook::Controls::BooleanConfig,
                       param: :active,
                       default: true
                     }
  end

  describe "#number" do
    context "with minimal args" do
      control :count, as: :number, default: 2

      include_examples "has controls attributes",
                       {
                         class: ViewComponent::Storybook::Controls::NumberConfig,
                         param: :count,
                         type: :number,
                         default: 2,
                         min: nil,
                         max: nil,
                         step: nil
                       }
    end

    context "with all args" do
      control :count, as: :number, default: 2, min: 0, max: 10, step: 1

      include_examples "has controls attributes",
                       {
                         class: ViewComponent::Storybook::Controls::NumberConfig,
                         param: :count,
                         type: :number,
                         default: 2,
                         min: 0,
                         max: 10,
                         step: 1
                       }
    end
  end

  describe "#range" do
    context "with minimal args" do
      control :count, as: :range, default: 2 

      include_examples "has controls attributes",
                       {
                         class: ViewComponent::Storybook::Controls::NumberConfig,
                         param: :count,
                         type: :range,
                         default: 2,
                         min: nil,
                         max: nil,
                         step: nil
                       }
    end

    context "with all args" do
      control :count, as: :range, default: 2, min: 0, max: 10, step: 1

      include_examples "has controls attributes",
                       {
                         class: ViewComponent::Storybook::Controls::NumberConfig,
                         param: :count,
                         type: :range,
                         default: 2,
                         min: 0,
                         max: 10,
                         step: 1
                       }
    end
  end

  describe "#color" do
    control :favorite, as: :color, default: "red"

    include_examples "has controls attributes",
                     {
                       class: ViewComponent::Storybook::Controls::ColorConfig,
                       param: :favorite,
                       default: "red"
                     }
  end

  describe "#object" do
    control :description, as: :object, default: { hair: "Brown", eyes: "Blue" }

    include_examples "has controls attributes",
                     {
                       class: ViewComponent::Storybook::Controls::ObjectConfig,
                       param: :description,
                       default: { hair: "Brown", eyes: "Blue" }
                     }
  end

  %w[select radio inline-radio].each do |type|
    control_type = type.underscore

    describe "##{control_type}" do
      control :food, as: control_type.to_sym, options: [:hot_dog, :pizza], default: :pizza

      include_examples "has controls attributes",
                       {
                         class: ViewComponent::Storybook::Controls::OptionsConfig,
                         param: :food,
                         type: type.to_sym,
                         default: :pizza,
                         options: [:hot_dog, :pizza]
                       }
    end
  end

  %w[multi-select check inline-check].each do |type|
    control_type = type.underscore

    describe "##{control_type}" do
      control :food, as: control_type.to_sym, options: [:hot_dog, :pizza], default: :pizza

      include_examples "has controls attributes",
                       {
                         class: ViewComponent::Storybook::Controls::MultiOptionsConfig,
                         param: :food,
                         type: type.to_sym,
                         default: [:pizza],
                         options: [:hot_dog, :pizza]
                       }
    end
  end
end
