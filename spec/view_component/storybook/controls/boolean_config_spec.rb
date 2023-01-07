# frozen_string_literal: true

RSpec.describe ViewComponent::Storybook::Controls::Boolean do
  subject { described_class.new(param, default: default_value, name: name, description: description) }

  let(:type) { :boolean }

  context "with 'true' value" do
    it_behaves_like "a simple controls config" do
      let(:default_value) { true }
      let(:param_value) { "true" }
    end
  end

  context "with 'false' value" do
    it_behaves_like "a simple controls config" do
      let(:default_value) { false }
      let(:param_value) { "false" }
    end
  end
end
