# frozen_string_literal: true

RSpec.describe ViewComponent::Storybook::Knobs::ArrayConfig do
  subject { described_class.new(component, param, value, separator, name: name, group_id: group_id) }

  let(:separator) { "," }

  it_behaves_like "a knobs config" do
    let(:type) { :array }
    let(:value) { %w[red orange yellow] }
    let(:param_value) { "red,orange,yellow" }
    let(:csf_params_overrides) { { separator: ",", value: %w[red orange yellow] } }

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
