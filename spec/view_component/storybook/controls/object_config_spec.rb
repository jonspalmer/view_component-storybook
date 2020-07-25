# frozen_string_literal: true

RSpec.describe ViewComponent::Storybook::Controls::ObjectConfig do
  subject { described_class.new(component, param, value, name: name) }

  let(:separator) { "," }

  it_behaves_like "a controls config" do
    let(:type) { :object }
    let(:value) { { color: "red", shape: "square" } }
    let(:param_value) { '{"color":"red","shape":"square"}' }

    let(:expected_csf_value) { { color: "red", shape: "square" } }
  end
end
