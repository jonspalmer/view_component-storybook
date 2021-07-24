# frozen_string_literal: true

RSpec.describe ViewComponent::Storybook::Dsl::ControlsDsl do
  include described_class

  shared_examples "has controls attributes" do |control_attributes|
    it "has expected attributes" do
      expect(subject).to have_attributes(control_attributes)
    end
  end

  describe "#text" do
    subject { text("Jane Doe") }

    include_examples "has controls attributes",
                     {
                       class: ViewComponent::Storybook::Controls::TextConfig,
                       default_value: "Jane Doe"
                     }
  end

  describe "#boolean" do
    subject { boolean(true) }

    include_examples "has controls attributes",
                     {
                       class: ViewComponent::Storybook::Controls::BooleanConfig,
                       default_value: true
                     }
  end

  describe "#number" do
    context "with minimal args" do
      subject { number(2) }

      include_examples "has controls attributes",
                       {
                         class: ViewComponent::Storybook::Controls::NumberConfig,
                         type: :number,
                         default_value: 2,
                         min: nil,
                         max: nil,
                         step: nil
                       }
    end

    context "with all args" do
      subject { number(2, min: 0, max: 10, step: 1) }

      include_examples "has controls attributes",
                       {
                         class: ViewComponent::Storybook::Controls::NumberConfig,
                         type: :number,
                         default_value: 2,
                         min: 0,
                         max: 10,
                         step: 1
                       }
    end
  end

  describe "#range" do
    context "with minimal args" do
      subject { range(2) }

      include_examples "has controls attributes",
                       {
                         class: ViewComponent::Storybook::Controls::NumberConfig,
                         type: :range,
                         default_value: 2,
                         min: nil,
                         max: nil,
                         step: nil
                       }
    end

    context "with all args" do
      subject { range(2, min: 0, max: 10, step: 1) }

      include_examples "has controls attributes",
                       {
                         class: ViewComponent::Storybook::Controls::NumberConfig,
                         type: :range,
                         default_value: 2,
                         min: 0,
                         max: 10,
                         step: 1
                       }
    end
  end

  describe "#color" do
    subject { color("red") }

    include_examples "has controls attributes",
                     {
                       class: ViewComponent::Storybook::Controls::ColorConfig,
                       default_value: "red"
                     }
  end

  describe "#object" do
    subject { object({ hair: "Brown", eyes: "Blue" }) }

    include_examples "has controls attributes",
                     {
                       class: ViewComponent::Storybook::Controls::ObjectConfig,
                       default_value: { hair: "Brown", eyes: "Blue" }
                     }
  end

  %w[select radio inline-radio].each do |type|
    dsl_method = type.underscore

    describe "##{dsl_method}" do
      subject { send(dsl_method, [:hot_dog, :pizza], :pizza) }

      include_examples "has controls attributes",
                       {
                         class: ViewComponent::Storybook::Controls::OptionsConfig,
                         type: type.to_sym,
                         default_value: :pizza,
                         options: [:hot_dog, :pizza]
                       }
    end
  end

  %w[multi-select check inline-check].each do |type|
    dsl_method = type.underscore

    describe "##{dsl_method}" do
      subject { send(dsl_method, [:hot_dog, :pizza], [:pizza]) }

      include_examples "has controls attributes",
                       {
                         class: ViewComponent::Storybook::Controls::MultiOptionsConfig,
                         type: type.to_sym,
                         default_value: [:pizza],
                         options: [:hot_dog, :pizza]
                       }
    end
  end

  describe "#custom" do
    subject do
      custom(first_name: "J.R.R.", last_name: "Tolkien") do |first_name:, last_name:|
        Author.new(first_name: first_name, last_name: last_name).full_name
      end
    end

    include_examples "has controls attributes",
                     {
                       class: ViewComponent::Storybook::Controls::CustomConfig
                     }

    it "returns cutom value from params" do
      from_params = subject.value_from_params({})
      expect(from_params).to eq("J.R.R. Tolkien")
    end
  end

  describe "#klazz" do
    subject do
      klazz(Author, first_name: "J.R.R.", last_name: "Tolkien")
    end

    include_examples "has controls attributes",
                     {
                       class: ViewComponent::Storybook::Controls::CustomConfig
                     }

    it "returns cutom value from params" do
      from_params = subject.value_from_params({})
      expect(from_params).to be_a(Author)
      expect(from_params.full_name).to eq("J.R.R. Tolkien")
    end
  end
end
