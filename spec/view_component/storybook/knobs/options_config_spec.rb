# frozen_string_literal: true

RSpec.describe ViewComponent::Storybook::Knobs::OptionsConfig do
  let(:options) { { Red: "red", Blue: "blue", Yellow: "yellow" } }

  described_class::TYPES.each do |type|
    context "type: #{type}" do
      let(:type) { type }

      it_behaves_like "a knobs config" do
        subject { described_class.new(type, component, param, options, value, name: name, group_id: group_id) }

        let(:value) { "blue" }
        let(:param_value) { "blue" }
        let(:csf_params_overrides) { { options: options, value: value } }
      end
    end
  end

  describe "#valid?" do
    it "invalid without type" do
      subject = described_class.new(nil, Demo::ButtonComponent, :button_text, options, "blue")

      expect(subject.valid?).to eq(false)
      expect(subject.errors.size).to eq(1)
      expect(subject.errors[:type]).to eq(["can't be blank"])
    end

    it "invalid with unsupported type" do
      subject = described_class.new(:foo, Demo::ButtonComponent, :button_text, options, "blue")

      expect(subject.valid?).to eq(false)
      expect(subject.errors.size).to eq(1)
      expect(subject.errors[:type]).to eq(["is not included in the list"])
    end

    it "invalid without default_value" do
      subject = described_class.new(:radios, Demo::ButtonComponent, :button_text, options, nil)

      expect(subject.valid?).to eq(false)
      expect(subject.errors.size).to eq(1)
      expect(subject.errors[:value]).to eq(["can't be blank"])
    end

    it "invalid with value not in the options list" do
      subject = described_class.new(:radios, Demo::ButtonComponent, :button_text, options, "green")

      expect(subject.valid?).to eq(false)
      expect(subject.errors.size).to eq(1)
      expect(subject.errors[:value]).to eq(["is not included in the list"])
    end
  end
end
