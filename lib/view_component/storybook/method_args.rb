# frozen_string_literal: true

require "active_support/dependencies/autoload"

module ViewComponent
  module Storybook
    module MethodArgs
      extend ActiveSupport::Autoload

      autoload :MethodArgs
      autoload :MethodParametersNames
      autoload :ControlMethodArgs
      autoload :ComponentConstructorArgs
      autoload :DryInitializerComponentConstructorArgs
    end
  end
end
