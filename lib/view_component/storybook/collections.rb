# frozen_string_literal: true

require "active_support/dependencies/autoload"

module ViewComponent
  module Storybook
    module Collections
      extend ActiveSupport::Autoload

      autoload :ValidForStoryConcern
      autoload :StoriesCollection
      autoload :ControlsCollection
      autoload :ParametersCollection
      autoload :LayoutCollection
    end
  end
end
