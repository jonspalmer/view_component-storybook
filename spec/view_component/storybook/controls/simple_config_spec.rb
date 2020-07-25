# frozen_string_literal: true

RSpec.describe ViewComponent::Storybook::Controls::SimpleConfig do
  subject { described_class.new(type, component, param, value, name: name) }

  context "with :text type" do
    let(:type) { :text }

    it_behaves_like "a controls config"
  end

  context "with :color type" do
    let(:type) { :color }

    it_behaves_like "a controls config"
  end

  context "with :boolean type" do
    let(:type) { :boolean }

    context "with 'true' value" do
      it_behaves_like "a controls config" do
        let(:value) { true }
        let(:param_value) { "true" }
        let(:expected_nil_value_erorr) { "is not included in the list" }
      end
    end

    context "with 'false' value" do
      it_behaves_like "a controls config" do
        let(:value) { false }
        let(:param_value) { "false" }
        let(:expected_nil_value_erorr) { "is not included in the list" }
      end
    end
  end

  describe "#valid?" do
    subject { described_class.new(type, Demo::ButtonComponent, :button_text, "OK") }

    context "without type" do
      let(:type) { nil }

      it "is invalid" do
        expect(subject.valid?).to eq(false)
        expect(subject.errors.size).to eq(1)
        expect(subject.errors[:type]).to eq(["can't be blank"])
      end
    end

    context "with unsupported type" do
      let(:type) { :foo }

      it "is invalid" do
        expect(subject.valid?).to eq(false)
        expect(subject.errors.size).to eq(1)
        expect(subject.errors[:type]).to eq(["is not included in the list"])
      end
    end
  end
end
