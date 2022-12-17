# frozen_string_literal: true

RSpec.describe ViewComponent::Storybook::Slots::SlotConfig do
  subject do
    described_class.from_component(SlotsComponent, :item, :item1, )
  end

  describe "#valid?" do
    context "with no args" do
      subject do
        described_class.from_component(SlotsComponent, :tab, :tab1)
      end

      it "validates method_args args" do
        expect(subject.valid?).to be(true)
      end
    end

    context "with too many args" do
      subject do
        described_class.from_component(SlotsComponent, :tab, :tab1, "OK!")
      end

      it "validates method_args args" do
        expect(subject.valid?).to be(false)
        expect(subject.errors[:slot_method_args].length).to eq(1)
      end
    end

    context "with default kwargs" do
      subject do
        described_class.from_component(SlotsComponent, :item, :item1)
      end

      it "validates method_args args" do
        expect(subject.valid?).to be(true)
      end
    end

    context "with optional kwargs" do
      subject do
        described_class.from_component(SlotsComponent, :item, :item1, highlighted: true)
      end

      it "validates method_args args" do
        expect(subject.valid?).to be(true)
      end
    end

    context "with too many kwargs" do
      subject do
        described_class.from_component(SlotsComponent, :item, :item1, highlighted: true, message: "Hello World!")
      end

      it "validates method_args args" do
        expect(subject.valid?).to be(false)
        expect(subject.errors[:slot_method_args].length).to eq(1)
      end
    end

    context "with too few kwargs" do
      subject do
        described_class.from_component(SlotsComponent, :item, :item1, message: "Hello World!")
      end

      it "validates method_args args" do
        expect(subject.valid?).to be(false)
        expect(subject.errors[:slot_method_args].length).to eq(1)
      end
    end

    context "with invalid controls" do
      subject do
        described_class.from_component(SlotsComponent, :item, :item1, message: ViewComponent::Storybook::Controls::TextConfig.new(true))
      end

      it "validates method_args args" do
        # This message is invalid because its value isn't a string
        expect(subject.valid?).to be(false)
        expect(subject.errors[:slot_method_args].length).to eq(1)
      end
    end

    context "with component slot" do
      context "with string component and correct args" do
        subject do
          described_class.from_component(SlotsComponent, :extra, :extra, message: "Hello World!")
        end

        it "validates method_args args" do
          expect(subject.valid?).to be(true)
        end
      end

      context "with class component and correct args" do
        subject do
          described_class.from_component(SlotsComponent, :example, :example, title: "Hello World!")
        end

        it "validates method_args args" do
          expect(subject.valid?).to be(true)
        end
      end

      context "with too many args" do
        subject do
          described_class.from_component(SlotsComponent, :extra, :extra, "Hi", message: "Hello World!")
        end

        it "validates method_args args" do
          # The slot_method_args are invalid because ExtraComponent doesn't have any positional args
          expect(subject.valid?).to be(false)
          expect(subject.errors[:slot_method_args].length).to eq(1)
        end
      end

      context "with too few kwargs" do
        subject do
          described_class.from_component(SlotsComponent, :extra, :extra)
        end

        it "validates method_args args" do
          # The slot_method_args are invalid because ExtraComponent requires a `message` kwargs
          expect(subject.valid?).to be(false)
          expect(subject.errors[:slot_method_args].length).to eq(1)
        end
      end

      context "with too many kwargs" do
        subject do
          described_class.from_component(SlotsComponent, :extra, :extra, message: "Hello World!", title: "Hi")
        end

        it "validates method_args args" do
          # The slot_method_args are invalid because ExtraComponent doesn't support a `do` kwargs
          expect(subject.valid?).to be(false)
          expect(subject.errors[:slot_method_args].length).to eq(1)
        end
      end
    end
  end
end
