# frozen_string_literal: true

shared_examples "a controls config" do
  let(:param) { :button_text }
  let(:name) { nil }
  let(:description) { nil }

  # describe "#param" do
  #   it "can be set" do
  #     subject.param(:name)

  #     expect(subject.param).to eq(:name)
  #   end

  #   it "set returns the control" do
  #     expect(subject.param(:name)).to eq(subject)
  #   end
  # end

  describe "#name" do
    it "by default is derived from the param" do
      expect(subject.name).to eq("Button Text")
    end

    context "with name" do
      let(:name) { "Button" }

      it "can be passed in the construcor" do
        expect(subject.name).to eq("Button")
      end
    end
  end

  describe '#description' do
    it "by default is nil" do
      expect(subject.description).to be_nil
    end

    context "with description" do
      let(:description) { "Text for the button" }

      it "can be passed in the constructor" do
        expect(subject.description).to eq("Text for the button")
      end
    end
  end

  describe "#valid?" do
    it "true for param that the component supports" do
      expect(subject.valid?).to be(true)
    end

    context "without a param" do
      let(:param) { nil }

      it "is invalid" do
        expect(subject.valid?).to be(false)
        expect(subject.errors.size).to eq(1)
        expect(subject.errors[:param]).to eq(["can't be blank"])
      end
    end
  end
end

shared_examples "a simple controls config" do
  include_examples "a controls config"

  let(:default_value) { "OK" }
  let(:value_from_param) { "OK" }

  it "#type" do
    expect(subject.type).to eq(type)
  end

  describe "#valid?" do
    context "without a default_value" do
      let(:default_value) { nil }

      it "is valid" do
        expect(subject.valid?).to be(true)
      end
    end
  end

  let(:expected_csf_value) { default_value }
  let(:csf_arg_type_control_overrides) { {} }
  let(:expected_csf_params) do
    {
      args: {
        button_text: expected_csf_value,
      },
      argTypes: {
        button_text: { control: { type: type }.merge(csf_arg_type_control_overrides), name: "Button Text" },
      },
    }
  end

  describe "#to_csf_params" do
    it "creates params" do
      expect(subject.to_csf_params).to eq(expected_csf_params)
    end

    context "with name" do
      let(:name) { "Text" }

      it "creates params" do
        name_params = { argTypes: { button_text: { name: "Text" } } }
        expect(subject.to_csf_params).to eq(expected_csf_params.deep_merge(name_params))
      end
    end

    context "with description" do
      let(:description) { "Descriptive Text" }

      it "creates params" do
        description_params = { argTypes: { button_text: { description: "Descriptive Text" } } }
        expect(subject.to_csf_params).to eq(expected_csf_params.deep_merge(description_params))
      end
    end

    it "calls validate!" do
      allow(subject).to receive(:validate!).and_raise ActiveModel::ValidationError.new(subject)

      expect { subject.to_csf_params }.to raise_error ActiveModel::ValidationError
      expect(subject).to have_received(:validate!).once
    end
  end

  let(:param_value) { "OK" }
  describe "#parse_param_value" do
    it "parses param_value" do
      expect(subject.parse_param_value(param_value)).to eq(default_value)
    end

    it "parses nil param_value" do
      expect(subject.parse_param_value(nil)).to be_nil
    end
  end
end

shared_examples "an options config" do |default_value|
  it_behaves_like "a simple controls config" do
    let(:default_value) { default_value }
    let(:param_value) { "blue" }

    let(:expected_csf_params) do
      control_labels = labels ? { labels: labels } : {}

      {
        args: {
          button_text: expected_csf_value,
        },
        argTypes: {
          button_text: { control: { type: type, **control_labels }, name: "Button Text", options: options },
        },
      }
    end
  end
end
