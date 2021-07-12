# frozen_string_literal: true

RSpec.describe ViewComponent::Storybook::StoryConfig do
  subject do
    described_class.new("example_story_config", "Example Story Config", ExampleComponent, false)
  end

  describe "#valid?" do
    it "is valid" do
      subject.constructor_args(
        title: ViewComponent::Storybook::Controls::TextConfig.new("OK")
      )

      expect(subject.valid?).to eq(true)
    end

    context "without too many args" do
      subject do
        story = described_class.new("mixed_args_story_config", "Mixed Args Story Config", MixedArgsComponent, false)
        story.constructor_args(
          ViewComponent::Storybook::Controls::TextConfig.new("OK"),
          ViewComponent::Storybook::Controls::TextConfig.new("Not OK!"),
          message: ViewComponent::Storybook::Controls::TextConfig.new("Hello World!")
        )
        story
      end

      it "validates constructor_args args" do
        expect(subject.valid?).to eq(false)
        expect(subject.errors[:constructor_args].length).to eq(1)
      end
    end

    context "without too few args" do
      subject do
        story = described_class.new("mixed_args_story_config", "Mixed Args Story Config", MixedArgsComponent, false)
        story.constructor_args(
          message: ViewComponent::Storybook::Controls::TextConfig.new("Hello World!")
        )
        story
      end

      it "validates constructor_args args" do
        expect(subject.valid?).to eq(false)
        expect(subject.errors[:constructor_args].length).to eq(1)
      end
    end

    it "validates constructor_args required kwargs" do
      # This control is invalid because its 'title' key is missing
      expect(subject.valid?).to eq(false)
      expect(subject.errors[:constructor_args].length).to eq(1)
    end

    it "validates constructor_args kwargs" do
      # This control is invalid because its key doesn't match the components kwargs
      subject.constructor_args(
        junk: ViewComponent::Storybook::Controls::TextConfig.new("OK")
      )
      expect(subject.valid?).to eq(false)
      expect(subject.errors[:constructor_args].length).to eq(1)
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
        subject.constructor_args(
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
        story.parameters = { size: :large, color: :red }
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
        subject.constructor_args(
          title: ViewComponent::Storybook::Controls::TextConfig.new("OK")
        )
        subject.parameters = { size: :large, color: :red }
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
        story.constructor_args(
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
        story.constructor_args(
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
        subject.constructor_args(
          junk: ViewComponent::Storybook::Controls::TextConfig.new("OK")
        )
      end

      it "raises an excpetion" do
        expect { subject.to_csf_params }.to(
          raise_exception(
            ViewComponent::Storybook::StoryConfig::ValidationError,
            "'Example Story Config' invalid: Constructor args is invalid, Kwargs 'junk' is invalid, Kwargs expected keys [title] but found [junk]"
          )
        )
      end
    end

    context "without required kwargs" do
      it "raises an excpetion" do
        expect { subject.to_csf_params }.to(
          raise_exception(
            ViewComponent::Storybook::StoryConfig::ValidationError,
            "'Example Story Config' invalid: Constructor args is invalid, Kwargs expected keys [title] but found []"
          )
        )
      end
    end

    context "without too many args" do
      subject do
        story = described_class.new("mixed_args_story_config", "Mixed Args Story Config", MixedArgsComponent, false)
        story.constructor_args(
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
            "'Mixed Args Story Config' invalid: Constructor args is invalid, Args expected no more than 1 but found 2"
          )
        )
      end
    end

    context "without too few args" do
      subject do
        story = described_class.new("mixed_args_story_config", "Mixed Args Story Config", MixedArgsComponent, false)
        story.constructor_args(
          message: ViewComponent::Storybook::Controls::TextConfig.new("Hello World!")
        )
        story
      end

      it "raises an excpetion" do
        expect { subject.to_csf_params }.to(
          raise_exception(
            ViewComponent::Storybook::StoryConfig::ValidationError,
            "'Mixed Args Story Config' invalid: Constructor args is invalid, Args expected at least 1 but found 0"
          )
        )
      end
    end
  end
end
