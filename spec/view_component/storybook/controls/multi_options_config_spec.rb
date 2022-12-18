# frozen_string_literal: true

RSpec.describe ViewComponent::Storybook::Controls::MultiOptions do
  described_class::TYPES.each do |type|
    context "type: #{type}" do
      subject { described_class.new(param, type: type, options: options, default: default_value, labels: labels, name: name, description: description) }

      let(:type) { type }
      let(:labels) { {} }

      context "with array options" do
        let(:options) { %w[red blue yellow] }

        it_behaves_like "an options config", ["blue"]

        context "with labels" do
          let(:labels) { { "red" => "Red", "blue" => "Blue", "yellow" => "Yellow" } }

          it_behaves_like "an options config", ["blue"]
        end
      end

      context "with symbol array values" do
        let(:options) { %i[red blue yellow] }

        it_behaves_like "an options config", [:blue]
      end
    end
  end

  describe "#parse_param_value" do
    subject { described_class.new(:opt, type: :check, options: options) }

    context "with array options" do
      let(:options) { %w[red blue yellow] }
      # let(:defualt_value) { ["blue"] }

      it "parses single param_value" do
        expect(subject.parse_param_value("blue")).to eq(["blue"])
      end

      it "parses multiple param_value" do
        expect(subject.parse_param_value("blue,red")).to eq(%w[blue red])
      end
    end

    context "with symbol options" do
      let(:options) { %i[red blue yellow] }
      # let(:defualt_value) { [:blue] }

      it "parses single param_value" do
        expect(subject.parse_param_value("blue")).to eq([:blue])
      end

      it "parses multiple param_value" do
        expect(subject.parse_param_value("blue,red")).to eq(%i[blue red])
      end
    end
  end

  describe "#valid?" do
    let(:options) { %w[red blue yellow] }

    it "valid with single array value" do
      subject = described_class.new(:button_text, type: :check, options: options, default: ["blue"])

      expect(subject.valid?).to be(true)
    end

    it "valid with multi array value" do
      subject = described_class.new(:button_text, type: :check, options: options, default: ["blue", "red"])

      expect(subject.valid?).to be(true)
    end

    it "valid with non-array value" do
      subject = described_class.new(:button_text, type: :check, options: options, default: "blue")

      expect(subject.valid?).to be(true)
    end

    it "valid with nil default provided its in the options list" do
      options << nil
      subject = described_class.new(:button_text, type: :check, options: options, default: nil)

      expect(subject.valid?).to be(true)
    end

    it "invalid without type" do
      subject = described_class.new(:button_text, type: nil, options: options, default: ["blue"])

      expect(subject.valid?).to be(false)
      expect(subject.errors.size).to eq(1)
      expect(subject.errors[:type]).to eq(["can't be blank"])
    end

    it "invalid with unsupported type" do
      subject = described_class.new(:button_text, type: :foo, options: options, default: ["blue"])

      expect(subject.valid?).to be(false)
      expect(subject.errors.size).to eq(1)
      expect(subject.errors[:type]).to eq(["is not included in the list"])
    end

    it "invalid with value not in the options list" do
      subject = described_class.new(:button_text, type: :check, options: options, default: ["green"] )

      expect(subject.valid?).to be(false)
      expect(subject.errors.size).to eq(1)
      expect(subject.errors[:default]).to eq(["is not included in the list"])
    end

    it "invalid with value partially in the options list" do
      subject = described_class.new(:button_text, type: :check, options: options, default: ["green", "red"])

      expect(subject.valid?).to be(false)
      expect(subject.errors.size).to eq(1)
      expect(subject.errors[:default]).to eq(["is not included in the list"])
    end
  end
end
