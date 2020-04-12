# frozen_string_literal: true

require "active_support/dependencies/autoload"

module ViewComponent
  module Storybook
    module Knobs
      extend ActiveSupport::Autoload

      autoload :KnobConfig
      autoload :SimpleConfig
      autoload :NumberConfig
      autoload :OptionsConfig
      autoload :ArrayConfig
      autoload :DateConfig
      autoload :ObjectConfig
    end
  end
end
