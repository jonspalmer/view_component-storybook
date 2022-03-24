# frozen_string_literal: true

RSpec.describe ViewComponent::Storybook::StoryConfig do
  subject do
    described_class.new("example_story_config", "Example Story Config", ExampleComponent, false)
  end

  describe "#valid?" do
    it "is valid" do
      subject.constructor(
        title: ViewComponent::Storybook::Controls::TextConfig.new("OK")
      )

      expect(subject.valid?).to be(true)
    end

    context "without too many args" do
      subject do
        story = described_class.new("mixed_args_story_config", "Mixed Args Story Config", MixedArgsComponent, false)
        story.constructor(
          ViewComponent::Storybook::Controls::TextConfig.new("OK"),
          ViewComponent::Storybook::Controls::TextConfig.new("Not OK!"),
          message: ViewComponent::Storybook::Controls::TextConfig.new("Hello World!")
        )
        story
      end

      it "validates constructor_args args" do
        expect(subject.valid?).to be(false)
        expect(subject.errors[:constructor_args].length).to eq(1)
      end
    end

    context "without too few args" do
      subject do
        story = described_class.new("mixed_args_story_config", "Mixed Args Story Config", MixedArgsComponent, false)
        story.constructor(
          message: ViewComponent::Storybook::Controls::TextConfig.new("Hello World!")
        )
        story
      end

      it "validates constructor_args args" do
        expect(subject.valid?).to be(false)
        expect(subject.errors[:constructor_args].length).to eq(1)
      end
    end

    it "validates constructor_args required kwargs" do
      # The constructor_args are invalid because its 'title' key is missing
      expect(subject.valid?).to be(false)
      expect(subject.errors[:constructor_args].length).to eq(1)
    end

    it "validates constructor_args kwargs" do
      # This control is invalid because its key doesn't match the components kwargs
      subject.constructor(
        junk: ViewComponent::Storybook::Controls::TextConfig.new("OK")
      )
      expect(subject.valid?).to be(false)
      expect(subject.errors[:constructor_args].length).to eq(1)
    end

    it "validates constructor_args controls" do
      # This control is invalid because its value isn't a boolean
      subject.constructor(
        title: ViewComponent::Storybook::Controls::BooleanConfig.new("OK")
      )
      expect(subject.valid?).to be(false)
      expect(subject.errors[:constructor_args].length).to eq(1)
    end

    context "with slots" do
      subject do
        described_class.new("slots_story_config", "Slots Story Config", SlotsV2Component, false)
      end

      context "with content only slot" do
        before do
          subject.tab
        end

        it "validates slots arguments" do
          expect(subject.valid?).to be(true)
        end
      end

      context "with lambda slot" do
        before do
          subject.item(highlighted: true)
        end

        it "validates slots arguments" do
          expect(subject.valid?).to be(true)
        end

        context "with invalid args" do
          before do
            subject.item(message: "Hi")
          end

          it "validates slots arguments" do
            expect(subject.valid?).to be(false)
            expect(subject.errors[:slots].length).to eq(1)
          end
        end
      end

      context "with Component slot" do
        before do
          subject.extra(message: "Hello World")
        end

        it "validates slots arguments" do
          expect(subject.valid?).to be(true)
        end

        context "with invalid args" do
          before do
            subject.extra(title: "His")
          end

          it "validates slots arguments" do
            expect(subject.valid?).to be(false)
            expect(subject.errors[:slots].length).to eq(1)
          end
        end
      end
    end

    context "with dry-initializer" do
      subject do
        described_class.new("dry_story_config", "Dry Story Config", DryComponent, false)
      end

      it "is valid" do
        subject.constructor(
          ViewComponent::Storybook::Controls::TextConfig.new("OK"),
          message: ViewComponent::Storybook::Controls::TextConfig.new("OK")
        )

        expect(subject.valid?).to be(true)
      end

      context "without too few args" do
        it "validates constructor_args args" do
          subject.constructor(
            message: ViewComponent::Storybook::Controls::TextConfig.new("Hello World!")
          )

          expect(subject.valid?).to be(false)
          expect(subject.errors[:constructor_args].length).to eq(1)
        end
      end

      it "validates constructor_args required kwargs" do
        subject.constructor(
          ViewComponent::Storybook::Controls::TextConfig.new("OK"),
        )

        # The constructor_args are invalid because its 'message' key is missing
        expect(subject.valid?).to be(false)
        expect(subject.errors[:constructor_args].length).to eq(1)
      end
    end
  end

  describe "#to_csf_params" do
    context "without controls" do
      subject do
        # use ArgsComponent as a component that doesn't require controls
        described_class.new("args_story_config", "Args Story Config", ArgsComponent, false)
      end

      it "writes csf params" do
        expect(subject.to_csf_params).to eq(
          {
            name: "Args Story Config",
            parameters: {
              server: { id: "args_story_config" }
            }
          }
        )
      end
    end

    context "with constructor_args" do
      before do
        subject.constructor(
          title: ViewComponent::Storybook::Controls::TextConfig.new("OK")
        )
      end

      it "writes csf params" do
        expect(subject.to_csf_params).to eq(
          {
            name: "Example Story Config",
            parameters: {
              server: { id: "example_story_config" }
            },
            args: {
              title: "OK"
            },
            argTypes: {
              title: { control: { type: :text }, name: "Title" }
            }
          }
        )
      end
    end

    context "with params" do
      subject do
        # use ArgsComponent as a component that doesn't require controls
        story = described_class.new("args_story_config", "Args Story Config", ArgsComponent, false)
        story.parameters(size: :large, color: :red)
        story
      end

      it "writes csf params" do
        expect(subject.to_csf_params).to eq(
          {
            name: "Args Story Config",
            parameters: {
              server: { id: "args_story_config" },
              size: :large,
              color: :red,
            }
          }
        )
      end
    end

    context "with constructor_args and params" do
      before do
        subject.constructor(
          title: ViewComponent::Storybook::Controls::TextConfig.new("OK")
        )
        subject.parameters(size: :large, color: :red)
      end

      it "writes csf params" do
        expect(subject.to_csf_params).to eq(
          {
            name: "Example Story Config",
            parameters: {
              server: { id: "example_story_config" },
              size: :large,
              color: :red,
            },
            args: {
              title: "OK"
            },
            argTypes: {
              title: { control: { type: :text }, name: "Title" }
            }
          }
        )
      end
    end

    context "with rest kwargs" do
      subject do
        story = described_class.new("kwargs_story_config", "Kwargs Story Config", KwargsComponent, false)
        story.constructor(
          message: ViewComponent::Storybook::Controls::TextConfig.new("Hello World!")
        )
        story
      end

      it "writes csf params" do
        expect(subject.to_csf_params).to eq(
          {
            name: "Kwargs Story Config",
            parameters: {
              server: { id: "kwargs_story_config" }
            },
            args: {
              message: "Hello World!"
            },
            argTypes: {
              message: { control: { type: :text }, name: "Message" }
            }
          }
        )
      end
    end

    context "with rest args" do
      subject do
        story = described_class.new("args_story_config", "Args Story Config", ArgsComponent, false)
        story.constructor(
          ViewComponent::Storybook::Controls::TextConfig.new("OK")
        )
        story
      end

      it "writes csf params" do
        expect(subject.to_csf_params).to eq(
          {
            name: "Args Story Config",
            parameters: {
              server: { id: "args_story_config" }
            },
            args: {
              items0: "OK"
            },
            argTypes: {
              items0: { control: { type: :text }, name: "Items0" }
            }
          }
        )
      end
    end

    context "with invalid kwargs" do
      before do
        subject.constructor(
          junk: ViewComponent::Storybook::Controls::TextConfig.new("OK")
        )
      end

      it "raises an excpetion" do
        expect { subject.to_csf_params }.to(
          raise_exception(
            ViewComponent::Storybook::StoryConfig::ValidationError,
            "'Example Story Config' invalid: (Constructor args invalid: (Kwargs 'junk' is invalid, Kwargs expected keys [title] but found [junk]))"
          )
        )
      end
    end

    context "without required kwargs" do
      it "raises an excpetion" do
        expect { subject.to_csf_params }.to(
          raise_exception(
            ViewComponent::Storybook::StoryConfig::ValidationError,
            "'Example Story Config' invalid: (Constructor args invalid: (Kwargs expected keys [title] but found []))"
          )
        )
      end
    end

    context "without too many args" do
      subject do
        story = described_class.new("mixed_args_story_config", "Mixed Args Story Config", MixedArgsComponent, false)
        story.constructor(
          ViewComponent::Storybook::Controls::TextConfig.new("OK"),
          ViewComponent::Storybook::Controls::TextConfig.new("Not OK!"),
          message: ViewComponent::Storybook::Controls::TextConfig.new("Hello World!")
        )
        story
      end

      it "raises an excpetion" do
        expect { subject.to_csf_params }.to(
          raise_exception(
            ViewComponent::Storybook::StoryConfig::ValidationError,
            "'Mixed Args Story Config' invalid: (Constructor args invalid: (Args expected no more than 1 but found 2))"
          )
        )
      end
    end

    context "without too few args" do
      subject do
        story = described_class.new("mixed_args_story_config", "Mixed Args Story Config", MixedArgsComponent, false)
        story.constructor(
          message: ViewComponent::Storybook::Controls::TextConfig.new("Hello World!")
        )
        story
      end

      it "raises an excpetion" do
        expect { subject.to_csf_params }.to(
          raise_exception(
            ViewComponent::Storybook::StoryConfig::ValidationError,
            "'Mixed Args Story Config' invalid: (Constructor args invalid: (Args expected at least 1 but found 0))"
          )
        )
      end
    end

    context "with invlaid controls" do
      before do
        subject.constructor(
          title: ViewComponent::Storybook::Controls::BooleanConfig.new("OK")
        )
      end

      it "raises an excpetion" do
        expect { subject.to_csf_params }.to(
          raise_exception(
            ViewComponent::Storybook::StoryConfig::ValidationError,
            "'Example Story Config' invalid: (Constructor args invalid: (Controls 'Title' is invalid: (Default value is not included in the list)))"
          )
        )
      end
    end

    context "with invlaid custom control" do
      before do
        # this custom control is invalid because the block args (greeting) don't agree with the controls args (message)
        message_control = ViewComponent::Storybook::Controls::TextConfig.new("Hello World!")
        custom_control = ViewComponent::Storybook::Controls::CustomConfig.new.with_value(message: message_control) do |greating:|
          "#{greating} Sarah"
        end
        subject.constructor(
          title: custom_control
        )
      end

      it "raises an excpetion" do
        expect { subject.to_csf_params }.to(
          raise_exception(
            ViewComponent::Storybook::StoryConfig::ValidationError,
            "'Example Story Config' invalid: (Constructor args invalid: (Controls 'Title' is invalid: (Value method args invalid: (Kwargs 'message' is invalid, Kwargs expected keys [greating] but found [message]))))"
          )
        )
      end
    end

    context "with slots" do
      subject do
        described_class.new("slots_story_config", "Slots Story Config", SlotsV2Component, false)
      end

      context "without controls" do
        before do
          subject.item
        end

        it "writes csf params" do
          expect(subject.to_csf_params).to eq(
            {
              name: "Slots Story Config",
              parameters: {
                server: { id: "slots_story_config" }
              }
            }
          )
        end
      end

      context "with lambda slot controls" do
        before do
          subject.item(highlighted: ViewComponent::Storybook::Controls::BooleanConfig.new(true))
        end

        it "writes csf params" do
          expect(subject.to_csf_params).to eq(
            {
              name: "Slots Story Config",
              parameters: {
                server: { id: "slots_story_config" }
              },
              args: {
                item1__highlighted: true
              },
              argTypes: {
                item1__highlighted: {
                  control: {
                    type: :boolean
                  },
                  name: "Item1  Highlighted"
                }
              }
            }
          )
        end
      end

      context "with component slot controls" do
        before do
          subject.example(title: ViewComponent::Storybook::Controls::TextConfig.new("Hello World!"))
        end

        it "writes csf params" do
          expect(subject.to_csf_params).to eq(
            {
              name: "Slots Story Config",
              parameters: {
                server: { id: "slots_story_config" }
              },
              args: {
                example__title: "Hello World!"
              },
              argTypes: {
                example__title: {
                  control: {
                    type: :text
                  },
                  name: "Example  Title"
                }
              }
            }
          )
        end
      end
    end
  end

  describe "slot methods" do
    subject do
      described_class.new("slots_story_config", "Slots Story Config", SlotsV2Component, false)
    end

    it "adds single slot method" do
      expect(subject.title).to be_a(ViewComponent::Storybook::Slots::SlotConfig)
    end

    it "adds collection slot method" do
      expect(subject.tabs).to be_a(ViewComponent::Storybook::Slots::SlotConfig)
    end

    it "adds collection item slot method" do
      expect(subject.tab).to be_a(ViewComponent::Storybook::Slots::SlotConfig)
    end

    it "raised an exception for non-slot method" do
      expect { subject.junk }.to raise_exception NoMethodError
    end
  end

  describe "respond_to_missing?" do
    subject do
      described_class.new("slots_story_config", "Slots Story Config", SlotsV2Component, false)
    end

    it "responds to single slot method" do
      expect(subject).to respond_to(:title)
    end

    it "responds to collection slot method" do
      expect(subject).to respond_to(:tabs)
    end

    it "responds to collection item slot method" do
      expect(subject).to respond_to(:tab)
    end

    it "does not respond non-slot method" do
      expect(subject).not_to respond_to(:junk)
    end
  end
end
