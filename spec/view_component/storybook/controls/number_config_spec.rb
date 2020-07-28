# frozen_string_literal: true

RSpec.describe ViewComponent::Storybook::Controls::NumberConfig do
  %i[number range].each do |number_type|
    context "with '#{number_type}' type" do
      subject { described_class.new(number_type, component, param, value, name: name) }

      it_behaves_like "a controls config" do
        let(:type) { number_type }
        let(:value) { 15 }
        let(:param_value) { "15" }
      end

      context "with float value" do
        it_behaves_like "a controls config" do
          let(:type) { number_type }
          let(:value) { 15.634 }
          let(:param_value) { "15.634" }
        end
      end

      context "with options" do
        subject { described_class.new(number_type, component, param, value, **number_options, name: name) }

        let(:number_options) { { min: 60, max: 90, step: 1 } }

        it_behaves_like "a controls config" do
          let(:type) { number_type }
          let(:value) { 15 }
          let(:param_value) { "15" }

          let(:csf_arg_type_control_overrides) { number_options }
        end
      end
    end
  end
end
