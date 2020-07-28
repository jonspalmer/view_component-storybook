# frozen_string_literal: true

RSpec.describe ViewComponent::Storybook::Controls::TextConfig do
  subject { described_class.new(component, param, value, name: name) }

  let(:type) { :text }

  it_behaves_like "a controls config"
end
