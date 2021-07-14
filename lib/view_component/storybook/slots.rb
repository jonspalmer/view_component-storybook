# frozen_string_literal: true

require "active_support/dependencies/autoload"

module ViewComponent
  module Storybook
    module Slots
      extend ActiveSupport::Autoload

      autoload :SlotConfig
      autoload :Slot
    end
  end
end
