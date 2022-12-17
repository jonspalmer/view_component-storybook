# frozen_string_literal: true

module Demo
  class HeadingComponentStoriesV2 < ViewComponent::Storybook::StoriesV2
    title 'Heading Component'

    # controls do
    #   text(:heading_text, "Heading")
    # end

    control :heading_text, as: :text, default: "Heading"

    def default(heading_text: "Heading")
      render HeadingComponent.new(heading_text: button_text)
    end
  end
end
