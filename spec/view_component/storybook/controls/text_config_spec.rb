# frozen_string_literal: true

RSpec.describe ViewComponent::Storybook::Controls::TextConfig do
  subject { described_class.new(value, param: param, name: name) }

  let(:type) { :text }

  it_behaves_like "a controls config"
end
