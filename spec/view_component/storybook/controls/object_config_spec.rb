# frozen_string_literal: true

RSpec.describe ViewComponent::Storybook::Controls::ObjectConfig do
  subject { described_class.new(component, param, value, name: name) }

  let(:separator) { "," }
  let(:type) { :object }

  it_behaves_like "a controls config" do
    let(:value) { { color: "red", shape: "square" } }
    let(:param_value) { '{"color":"red","shape":"square"}' }

    let(:expected_csf_value) { { color: "red", shape: "square" } }
  end

  context "with nested value" do
    it_behaves_like "a controls config" do
      let(:value) { { shape: "square", options: { color: "red", size: 10 } } }
      let(:param_value) { '{"shape":"square","options":{"color":"red", "size":10}}' }

      let(:expected_csf_value) { { shape: "square", options: { color: "red", size: 10 } } }
    end
  end
end
