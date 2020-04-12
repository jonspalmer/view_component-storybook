# frozen_string_literal: true

RSpec.describe ViewComponent::Storybook::Knobs::DateConfig do
  subject { described_class.new(component, param, value, name: name, group_id: group_id) }

  shared_examples "valid with object value" do
    it "has a value" do
      expect(subject.value).to eq(value)
    end

    it "to_csf_params should leave value alone" do
      subject.to_csf_params
      expect(subject.value).to eq(value)
    end

    it "is valid" do
      expect(subject.valid?).to eq(true)
    end

    it "has an integer value in csf_params" do
      expect(subject.to_csf_params).to eq(type: type, param: :button_text, name: "Button Text", value: expected_value)
    end
  end

  let(:type) { :date }

  context "with Date value" do
    it_behaves_like "a knobs config" do
      let(:value) { Date.new(2020, 2, 15) }
      let(:expected_value) { "2020-02-15T00:00:00Z" }
      let(:param_value) { "2020-02-15T00:00:00Z" }
      let(:csf_params_overrides) { { value: param_value } }

      include_examples "valid with object value"
    end
  end

  context "with DateTime value" do
    it_behaves_like "a knobs config" do
      let(:value) { Time.utc(2020, 2, 15, 2, 30, 45).to_datetime }
      let(:expected_value) { "2020-02-15T02:30:45Z" }
      let(:param_value) { "2020-02-15T02:30:45Z" }
      let(:csf_params_overrides) { { value: param_value } }

      include_examples "valid with object value"
    end
  end

  context "with Time value" do
    it_behaves_like "a knobs config" do
      let(:value) { Time.utc(2020, 2, 15, 2, 30, 45) }
      let(:expected_value) { "2020-02-15T02:30:45Z" }
      let(:param_value) { "2020-02-15T02:30:45Z" }
      let(:csf_params_overrides) { { value: param_value } }

      include_examples "valid with object value"
    end
  end
end
