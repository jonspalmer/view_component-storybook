# frozen_string_literal: true

RSpec.describe ViewComponent::Storybook::Knobs::NumberConfig do
  subject { described_class.new(component, param, value, name: name, group_id: group_id) }

  it_behaves_like "a knobs config" do
    let(:type) { :number }
    let(:value) { 15 }
    let(:param_value) { "15" }
  end

  context "with float value" do
    it_behaves_like "a knobs config" do
      let(:type) { :number }
      let(:value) { 15.634 }
      let(:param_value) { "15.634" }
    end
  end

  context "with options" do
    subject { described_class.new(component, param, value, number_options, name: name, group_id: group_id) }

    let(:number_options) { { range: true, min: 60, max: 90, step: 1 } }

    it_behaves_like "a knobs config" do
      let(:type) { :number }
      let(:value) { 15 }
      let(:param_value) { "15" }

      let(:csf_params_overrides) { { options: number_options } }
    end
  end
end
