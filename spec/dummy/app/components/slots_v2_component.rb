# frozen_string_literal: true

class SlotsV2Component < ViewComponent::Base
  renders_one :title
  renders_one :subtitle
  renders_one :footer, ->(classes: "") do
    tag.footer(class: "footer #{classes}") do
      # block.call if block
    end
  end

  renders_many :tabs

  renders_many :items, ->(highlighted: false) do
    MyHighlightComponent.new(highlighted: highlighted)
  end

  renders_one :extra, "ExtraComponent"

  renders_one :example, ExampleComponent

  def initialize(classes: "")
    super
    @classes = classes
  end

  class MyHighlightComponent < ViewComponent::Base
    def initialize(highlighted: false)
      super
      @highlighted = highlighted
    end

    def classes
      @highlighted ? "highlighted" : "normal"
    end
  end

  class ExtraComponent < ViewComponent::Base
    def initialize(message:)
      super
      @message = message
    end

    def call
      render(ErbComponent.new(message: @message)) { content }
    end
  end
end
