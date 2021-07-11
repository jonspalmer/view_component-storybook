# frozen_string_literal: true

RSpec.describe ViewComponent::Storybook::StoryConfig do
  subject do
    described_class.new("example_story_config", "Example Story Config", ExampleComponent, false)
  end

  describe "#valid?" do
    it "is valid" do
      subject.constructor_args = ViewComponent::Storybook::ControlMethodArgs.new(
        title: ViewComponent::Storybook::Controls::TextConfig.new("OK", param: :title)
      )

      expect(subject.valid?).to eq(true)
    end

    xit "duplicate controls are invalid" do
      subject.controls << ViewComponent::Storybook::Controls::TextConfig.new(ExampleComponent, :title, "OK")
      subject.controls << ViewComponent::Storybook::Controls::TextConfig.new(ExampleComponent, :title, "Not OK!")

      expect(subject.valid?).to eq(false)
      expect(subject.errors[:controls].length).to eq(1)
    end

    xit "duplicate controls with different types are invalid" do
      subject.controls << ViewComponent::Storybook::Controls::TextConfig.new(ExampleComponent, :title, "OK")
      subject.controls << ViewComponent::Storybook::Controls::NumberConfig.new(:number, ExampleComponent, :title, 666)
      expect(subject.valid?).to eq(false)
      expect(subject.errors[:controls].length).to eq(1)
    end

    xit "validates constructor_args keys" do
      # This control is invalid because its key doesn't match the components kwargs
      subject.constructor_args = ViewComponent::Storybook::ControlMethodArgs.new(
        junk: ViewComponent::Storybook::Controls::TextConfig.new("OK", param: :junk)
      )
      expect(subject.valid?).to eq(false)
      expect(subject.errors[:controls].length).to eq(1)
    end
  end

  describe "#to_csf_params" do
    it "writes csf params" do
      expect(subject.to_csf_params).to eq(
        {
          name: "Example Story Config",
          parameters: {
            server: { id: "example_story_config" }
          }
        }
      )
    end

    context "with controls" do
      before do
        subject.constructor_args = ViewComponent::Storybook::ControlMethodArgs.new(
          title: ViewComponent::Storybook::Controls::TextConfig.new("OK", param: :title)
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
      before do
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
            }
          }
        )
      end
    end

    context "with controls and params" do
      before do
        subject.constructor_args = ViewComponent::Storybook::ControlMethodArgs.new(
          title: ViewComponent::Storybook::Controls::TextConfig.new("OK", param: :title)
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

    xcontext "with invalid config" do
      before do
        # This control is invalid because its key doesn't match the components kwargs
        subject.constructor_args = ViewComponent::Storybook::ControlMethodArgs.new(
          junk: ViewComponent::Storybook::Controls::TextConfig.new("OK", param: :junk)
        )
      end

      it "raises an excpetion" do
        expect { subject.to_csf_params }.to(
          raise_exception(
            ViewComponent::Storybook::StoryConfig::ValidationError,
            "'Example Story Config' invalid: Controls is invalid, Control 'Junk' invalid: Param 'junk' is not supported by the component."
          )
        )
      end
    end
  end
end
