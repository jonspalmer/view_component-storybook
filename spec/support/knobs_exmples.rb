# frozen_string_literal: true

shared_examples "a knobs config" do
  let(:component) { Demo::ButtonComponent }
  let(:param) { :button_text }
  let(:value) { "OK" }
  let(:name) { nil }
  let(:group_id) { nil }
  let(:expected_nil_value_erorr) { "can't be blank" } # booleans are slightly different

  it "#type" do
    expect(subject.type).to eq(type)
  end

  describe "#name" do
    it "by default is dereived from the param" do
      expect(subject.name).to eq("Button Text")
    end

    context "with name" do
      let(:name) { "Button" }

      it "can be passed in the construcor" do
        expect(subject.name).to eq("Button")
      end
    end
  end

  describe "#valid?" do
    it "true for param that the component supports" do
      expect(subject.valid?).to eq(true)
    end

    context "with unsupported param" do
      let(:param) { :foo }

      it "is invalid" do
        expect(subject.valid?).to eq(false)
        expect(subject.errors.size).to eq(1)
        expect(subject.errors[:param]).to eq(["is not included in the list"])
      end
    end

    context "without a value" do
      let(:value) { nil }

      it "is invalid" do
        expect(subject.valid?).to eq(false)
        expect(subject.errors.size).to eq(1)
        expect(subject.errors[:value]).to eq([expected_nil_value_erorr])
      end
    end

    context "without a component" do
      let(:component) { nil }

      it "is invalid" do
        expect(subject.valid?).to eq(false)
        expect(subject.errors.size).to eq(1)
        expect(subject.errors[:component]).to eq(["can't be blank"])
      end
    end
  end

  let(:csf_params_overrides) { {} }
  let(:expected_csf_params) { { type: type, param: :button_text, name: "Button Text", value: value }.merge(csf_params_overrides) }

  describe "#to_csf_params" do
    it "creates params" do
      expect(subject.to_csf_params).to eq(expected_csf_params)
    end

    context "with all options" do
      let(:name) { "Text" }
      let(:group_id) { "Buttons" }

      it "creates params" do
        expect(subject.to_csf_params).to eq(expected_csf_params.merge(name: "Text", group_id: "Buttons"))
      end
    end

    it "calls validate!" do
      allow(subject).to receive(:validate!).and_raise ActiveModel::ValidationError.new(subject)

      expect { subject.to_csf_params }.to raise_error ActiveModel::ValidationError
      expect(subject).to have_received(:validate!).once
    end
  end

  let(:param_value) { "OK" }
  describe "#value_from_param" do
    it "parses param_value" do
      expect(subject.value_from_param(param_value)).to eq(value)
    end

    it "parses nil param_value" do
      expect(subject.value_from_param(nil)).to eq(nil)
    end
  end
end
