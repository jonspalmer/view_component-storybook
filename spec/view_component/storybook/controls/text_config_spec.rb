# frozen_string_literal: true

RSpec.describe ViewComponent::Storybook::Controls::TextConfig do
  subject { described_class.new(default_value, param: param, name: name, description: description) }

  let(:type) { :text }

  it_behaves_like "a simple controls config"
end
