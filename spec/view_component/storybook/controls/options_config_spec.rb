# frozen_string_literal: true

RSpec.describe ViewComponent::Storybook::Controls::OptionsConfig do
  let(:options) { { Red: "red", Blue: "blue", Yellow: "yellow" } }

  described_class::TYPES.each do |type|
    context "type: #{type}" do
      let(:type) { type }

      it_behaves_like "a controls config" do
        subject { described_class.new(type, component, param, options, value, name: name) }

        let(:value) { "blue" }
        let(:param_value) { "blue" }

        let(:csf_arg_type_control_overrides) { { options: options } }
      end

      context "with symbol values" do
        let(:options) { { Red: :red, Blue: :blue, Yellow: :yellow } }

        it_behaves_like "a controls config" do
          subject { described_class.new(type, component, param, options, value, name: name) }

          let(:value) { :blue }
          let(:param_value) { "blue" }

          let(:csf_arg_type_control_overrides) { { options: options } }
        end
      end

      context "with array options" do
        let(:options) { %w[red blue yellow] }

        it_behaves_like "a controls config" do
          subject { described_class.new(type, component, param, options, value, name: name) }

          let(:value) { "blue" }
          let(:param_value) { "blue" }

          let(:csf_arg_type_control_overrides) { { options: options } }
        end
      end

      context "with symbol array values" do
        let(:options) { %i[red blue yellow] }

        it_behaves_like "a controls config" do
          subject { described_class.new(type, component, param, options, value, name: name) }

          let(:value) { :blue }
          let(:param_value) { "blue" }

          let(:csf_arg_type_control_overrides) { { options: options } }
        end
      end
    end
  end

  describe "#valid?" do
    it "invalid without type" do
      subject = described_class.new(nil, Demo::ButtonComponent, :button_text, options, "blue")

      expect(subject.valid?).to eq(false)
      expect(subject.errors.size).to eq(1)
      expect(subject.errors[:type]).to eq(["can't be blank"])
    end

    it "invalid with unsupported type" do
      subject = described_class.new(:foo, Demo::ButtonComponent, :button_text, options, "blue")

      expect(subject.valid?).to eq(false)
      expect(subject.errors.size).to eq(1)
      expect(subject.errors[:type]).to eq(["is not included in the list"])
    end

    it "invalid with value not in the options hash" do
      subject = described_class.new(:radio, Demo::ButtonComponent, :button_text, options, "green")

      expect(subject.valid?).to eq(false)
      expect(subject.errors.size).to eq(1)
      expect(subject.errors[:value]).to eq(["is not included in the list"])
    end

    context "with array options" do
      let(:options) { %w[red blue yellow] }

      it "invalid with value not in the options list" do
        subject = described_class.new(:radio, Demo::ButtonComponent, :button_text, options, "green")

        expect(subject.valid?).to eq(false)
        expect(subject.errors.size).to eq(1)
        expect(subject.errors[:value]).to eq(["is not included in the list"])
      end

      it "valid with nil default_value provided its in the options list" do
        options << nil
        subject = described_class.new(:radio, Demo::ButtonComponent, :button_text, options, nil)

        expect(subject.valid?).to eq(true)
      end
    end
  end
end
