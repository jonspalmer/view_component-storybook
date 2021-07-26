# frozen_string_literal: true

require "active_support/dependencies/autoload"

module ViewComponent
  module Storybook
    module Dsl
      extend ActiveSupport::Autoload

      autoload :LegacyControlsDsl
    end
  end
end
