# frozen_string_literal: true

RSpec.describe ViewComponent::Storybook::Controls::OptionsConfig do
  described_class::TYPES.each do |type|
    context "type: #{type}" do
      let(:type) { type }

      context "with array options" do
        let(:options) { %w[red blue yellow] }

        it_behaves_like "a simple controls config" do
          subject { described_class.new(type, options, default_value, param: param, name: name) }

          let(:default_value) { "blue" }
          let(:param_value) { "blue" }

          let(:expected_csf_params) do
            {
              args: {
                button_text: expected_csf_value,
              },
              argTypes: {
                button_text: { control: { type: type }, name: "Button Text", options: options },
              },
            }
          end
        end

        context "with labels" do
          it_behaves_like "a simple controls config" do
            subject do
              described_class.new(
                type,
                options,
                default_value,
                labels: { "red" => "Red", "blue" => "Blue", "yellow" => "Yellow" },
                param: param,
                name: name
              )
            end

            let(:default_value) { "blue" }
            let(:param_value) { "blue" }

            let(:expected_csf_params) do
              {
                args: {
                  button_text: expected_csf_value,
                },
                argTypes: {
                  button_text: {
                    control: {
                      type: type,
                      labels: { "red" => "Red", "blue" => "Blue", "yellow" => "Yellow" }
                    },
                    name: "Button Text",
                    options: options
                  },
                },
              }
            end
          end
        end
      end

      context "with symbol array values" do
        let(:options) { %i[red blue yellow] }

        it_behaves_like "a simple controls config" do
          subject { described_class.new(type, options, default_value, param: param, name: name) }

          let(:default_value) { :blue }
          let(:param_value) { "blue" }

          let(:expected_csf_params) do
            {
              args: {
                button_text: expected_csf_value,
              },
              argTypes: {
                button_text: { control: { type: type }, name: "Button Text", options: options },
              },
            }
          end
        end
      end
    end
  end

  describe "#valid?" do
    let(:options) { %w[red blue yellow] }

    it "invalid without type" do
      subject = described_class.new(nil, options, "blue", param: :button_text)

      expect(subject.valid?).to eq(false)
      expect(subject.errors.size).to eq(1)
      expect(subject.errors[:type]).to eq(["can't be blank"])
    end

    it "invalid with unsupported type" do
      subject = described_class.new(:foo, options, "blue", param: :button_text)

      expect(subject.valid?).to eq(false)
      expect(subject.errors.size).to eq(1)
      expect(subject.errors[:type]).to eq(["is not included in the list"])
    end

    it "invalid with value not in the options list" do
      subject = described_class.new(:radio, options, "green", param: :button_text)

      expect(subject.valid?).to eq(false)
      expect(subject.errors.size).to eq(1)
      expect(subject.errors[:default_value]).to eq(["is not included in the list"])
    end

    it "valid with nil default_value provided its in the options list" do
      options << nil
      subject = described_class.new(:radio, options, nil, param: :button_text)

      expect(subject.valid?).to eq(true)
    end
  end
end
