# frozen_string_literal: true

RSpec.describe ViewComponent::Storybook::Knobs::ObjectConfig do
  subject { described_class.new(component, param, value, name: name, group_id: group_id) }

  let(:separator) { "," }

  it_behaves_like "a knobs config" do
    let(:type) { :object }
    let(:value) { { color: "red", shape: "square" } }
    let(:param_value) { '{"color":"red","shape":"square"}' }
    let(:csf_params_overrides) { { value: { color: "red", shape: "square" } } }
  end
end
