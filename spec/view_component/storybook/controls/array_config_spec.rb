# frozen_string_literal: true

RSpec.describe ViewComponent::Storybook::Controls::ArrayConfig do
  subject { described_class.new(default_value, separator, param: param, name: name) }

  let(:separator) { "," }

  it_behaves_like "a controls config" do
    let(:type) { :array }
    let(:default_value) { %w[red orange yellow] }
    let(:param_value) { "red,orange,yellow" }

    let(:expect_csf_value) { %w[red orange yellow] }
    let(:csf_arg_type_control_overrides) { { separator: "," } }

    context "without a separator" do
      let(:separator) { nil }

      it "is invalid" do
        expect(subject.valid?).to eq(false)
        expect(subject.errors.size).to eq(1)
        expect(subject.errors[:separator]).to eq(["can't be blank"])
      end
    end
  end
end
