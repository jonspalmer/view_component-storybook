# frozen_string_literal: true

require "active_support/dependencies/autoload"

module ViewComponent
  module Storybook
    module Controls
      extend ActiveSupport::Autoload

      autoload :ControlConfig
      autoload :SimpleConfig
      autoload :NumberConfig
      autoload :OptionsConfig
      autoload :ArrayConfig
      autoload :DateConfig
      autoload :ObjectConfig
    end
  end
end
