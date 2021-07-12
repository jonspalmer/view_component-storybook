# frozen_string_literal: true

RSpec.describe ViewComponent::Storybook::Controls::ObjectConfig do
  subject { described_class.new(default_value, param: param, name: name) }

  let(:separator) { "," }
  let(:type) { :object }

  it_behaves_like "a controls config" do
    let(:default_value) { { color: "red", shape: "square" } }
    let(:param_value) { '{"color":"red","shape":"square"}' }

    let(:expected_csf_value) { { color: "red", shape: "square" } }
  end

  context "with nested value" do
    it_behaves_like "a controls config" do
      let(:default_value) { { shape: "square", options: { color: "red", size: 10 } } }
      let(:param_value) { '{"shape":"square","options":{"color":"red", "size":10}}' }

      let(:expected_csf_value) { { shape: "square", options: { color: "red", size: 10 } } }
    end
  end

  context "with an array of objects" do
    it_behaves_like "a controls config" do
      let(:default_value) { [{ shape: 'square', color: 'red' }, { shape: 'circle', color: 'green' }] }
      let(:param_value) { '[{"shape": "square", "color": "red"},{"shape": "circle", "color": "green"}]' }

      let(:expected_csf_value) { [{ shape: 'square', color: 'red' }, { shape: 'circle', color: 'green' }] }
    end
  end
end
