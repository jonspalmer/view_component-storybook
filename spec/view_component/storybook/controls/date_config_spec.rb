# frozen_string_literal: true

RSpec.describe ViewComponent::Storybook::Controls::DateConfig do
  subject { described_class.new(default_value, param: param, name: name) }

  shared_examples "valid with object value" do
    it "has a value" do
      expect(subject.default_value).to eq(default_value)
    end

    it "to_csf_params should leave value alone" do
      subject.to_csf_params
      expect(subject.default_value).to eq(default_value)
    end

    it "is valid" do
      expect(subject.valid?).to eq(true)
    end

    it "has an integer value in csf_params" do
      expect(subject.to_csf_params).to eq(
        {
          args: {
            button_text: expected_csf_value,
          },
          argTypes: {
            button_text: { control: { type: type }, name: "Button Text" },
          },
        }
      )
    end
  end

  let(:type) { :date }

  context "with Date value" do
    it_behaves_like "a simple controls config" do
      let(:default_value) { Date.new(2020, 2, 15) }
      let(:param_value) { "2020-02-15T00:00:00Z" }

      let(:expected_csf_value) { "2020-02-15T00:00:00Z" }

      include_examples "valid with object value"
    end
  end

  context "with DateTime value" do
    it_behaves_like "a simple controls config" do
      let(:default_value) { Time.utc(2020, 2, 15, 2, 30, 45).to_datetime }
      let(:param_value) { "2020-02-15T02:30:45Z" }

      let(:expected_csf_value) { "2020-02-15T02:30:45Z" }

      include_examples "valid with object value"
    end
  end

  context "with Time value" do
    it_behaves_like "a simple controls config" do
      let(:default_value) { Time.utc(2020, 2, 15, 2, 30, 45) }
      let(:param_value) { "2020-02-15T02:30:45Z" }

      let(:expected_csf_value) { "2020-02-15T02:30:45Z" }

      include_examples "valid with object value"
    end
  end
end
