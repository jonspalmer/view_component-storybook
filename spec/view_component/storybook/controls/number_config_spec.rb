# frozen_string_literal: true

RSpec.describe ViewComponent::Storybook::Controls::Number do
  described_class::TYPES.each do |number_type|
    context "with '#{number_type}' type" do
      subject { described_class.new(param, type: number_type, default: default_value, name: name, description: description) }

      it_behaves_like "a simple controls config" do
        let(:type) { number_type }
        let(:default_value) { 15 }
        let(:param_value) { "15" }
      end

      context "with float value" do
        it_behaves_like "a simple controls config" do
          let(:type) { number_type }
          let(:default_value) { 15.634 }
          let(:param_value) { "15.634" }
        end
      end

      context "with options" do
        subject { described_class.new(param, type: number_type, default: default_value, **number_options, name: name, description: description) }

        let(:number_options) { { min: 60, max: 90, step: 1 } }

        it_behaves_like "a simple controls config" do
          let(:type) { number_type }
          let(:default_value) { 15 }
          let(:param_value) { "15" }

          let(:csf_arg_type_control_overrides) { number_options }
        end
      end
    end
  end

  describe "#valid?" do
    it "invalid without type" do
      subject = described_class.new(:button_text, type: nil, default: "blue")

      expect(subject.valid?).to be(false)
      expect(subject.errors.size).to eq(1)
      expect(subject.errors[:type]).to eq(["can't be blank"])
    end

    it "invalid with unsupported type" do
      subject = described_class.new(:button_text, type: :foo, default: "blue")

      expect(subject.valid?).to be(false)
      expect(subject.errors.size).to eq(1)
      expect(subject.errors[:type]).to eq(["is not included in the list"])
    end
  end
end
