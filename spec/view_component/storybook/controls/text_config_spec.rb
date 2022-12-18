# frozen_string_literal: true

RSpec.describe ViewComponent::Storybook::Controls::Text do
  subject { described_class.new(param, default: default_value, name: name, description: description) }

  let(:type) { :text }

  it_behaves_like "a simple controls config"
end
