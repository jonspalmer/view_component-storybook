# frozen_string_literal: true

require "active_support/dependencies/autoload"

module ViewComponent
  module Storybook
    module Controls
      extend ActiveSupport::Autoload

      autoload :ControlConfig
      autoload :SimpleControlConfig
      autoload :TextConfig
      autoload :BooleanConfig
      autoload :ColorConfig
      autoload :NumberConfig
      autoload :BaseOptionsConfig
      autoload :OptionsConfig
      autoload :MultiOptionsConfig
      autoload :DateConfig
      autoload :ObjectConfig
      autoload :CustomConfig
      autoload :ControlsHelpers
      autoload :ControlsCollection
    end
  end
end
