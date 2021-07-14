# frozen_string_literal: true

RSpec.describe ViewComponent::Storybook::Controls::CustomConfig do
  subject do
    described_class.new(param: param, name: name).with_value(
      message: ViewComponent::Storybook::Controls::TextConfig.new("Hello")
    ) do |message:|
      message.upcase
    end
  end

  let(:param) { :greeting }
  let(:name) { nil }

  it_behaves_like "a controls config"

  describe "#valid?" do
    it { is_expected.to be_valid }

    context "with args missmatch" do
      subject do
        described_class.new(param: param, name: name).with_value(
          message: ViewComponent::Storybook::Controls::TextConfig.new("Hello")
        ) do |msg:|
          msg.upcase
        end
      end

      it { is_expected.to be_invalid }
    end
  end

  describe "#to_csf_params" do
    it "creates params" do
      expect(subject.to_csf_params).to eq(
        {
          args: {
            greeting__message: "Hello",
          },
          argTypes: {
            greeting__message: { control: { type: :text }, name: "Greeting  Message" },
          },
        }
      )
    end

    it "calls validate!" do
      allow(subject).to receive(:validate!).and_raise ActiveModel::ValidationError.new(subject)

      expect { subject.to_csf_params }.to raise_error ActiveModel::ValidationError
      expect(subject).to have_received(:validate!).once
    end
  end

  describe "#value_from_params" do
    it "uses default value" do
      expect(subject.value_from_params({})).to eq("HELLO")
    end

    it "parses param value" do
      expect(subject.value_from_params(greeting__message: "Hello World!")).to eq("HELLO WORLD!")
    end
  end
end
