# frozen_string_literal: true

RSpec.describe ViewComponent::Storybook::Controls::BooleanConfig do
  subject { described_class.new(value, param: param, name: name) }

  let(:type) { :boolean }

  context "with 'true' value" do
    it_behaves_like "a controls config" do
      let(:value) { true }
      let(:param_value) { "true" }
    end
  end

  context "with 'false' value" do
    it_behaves_like "a controls config" do
      let(:value) { false }
      let(:param_value) { "false" }
    end
  end
end
