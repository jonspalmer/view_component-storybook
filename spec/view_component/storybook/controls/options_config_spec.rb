# frozen_string_literal: true

RSpec.describe ViewComponent::Storybook::Controls::OptionsConfig do
  described_class::TYPES.each do |type|
    context "type: #{type}" do
      subject { described_class.new(type, options, default_value, labels: labels, param: param, name: name) }

      let(:type) { type }
      let(:labels) { {} }

      context "with array options" do
        let(:options) { %w[red blue yellow] }

        it_behaves_like "an options config", "blue"

        context "with labels" do
          let(:labels) { { "red" => "Red", "blue" => "Blue", "yellow" => "Yellow" } }

          it_behaves_like "an options config", "blue"
        end
      end

      context "with symbol array values" do
        let(:options) { %i[red blue yellow] }
        let(:labels) { {} }

        it_behaves_like "an options config", :blue
      end
    end
  end

  describe "#valid?" do
    let(:options) { %w[red blue yellow] }

    it "valid with value" do
      subject = described_class.new(:radio, options, "blue", param: :button_text)

      expect(subject.valid?).to eq(true)
    end

    it "invalid without type" do
      subject = described_class.new(nil, options, "blue", param: :button_text)

      expect(subject.valid?).to eq(false)
      expect(subject.errors.size).to eq(1)
      expect(subject.errors[:type]).to eq(["can't be blank"])
    end

    it "invalid with unsupported type" do
      subject = described_class.new(:foo, options, "blue", param: :button_text)

      expect(subject.valid?).to eq(false)
      expect(subject.errors.size).to eq(1)
      expect(subject.errors[:type]).to eq(["is not included in the list"])
    end

    it "invalid with value not in the options list" do
      subject = described_class.new(:radio, options, "green", param: :button_text)

      expect(subject.valid?).to eq(false)
      expect(subject.errors.size).to eq(1)
      expect(subject.errors[:default_value]).to eq(["is not included in the list"])
    end

    it "valid with nil default_value provided its in the options list" do
      options << nil
      subject = described_class.new(:radio, options, nil, param: :button_text)

      expect(subject.valid?).to eq(true)
    end
  end
end
