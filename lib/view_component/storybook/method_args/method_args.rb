# frozen_string_literal: true

module ViewComponent
  module Storybook
    module MethodArgs
      ##
      # Simple class representing arguments passed to a method
      class MethodArgs
        attr_reader :args, :kwargs, :block

        def initialize(args, kwargs, block)
          @args = args
          @kwargs = kwargs
          @block = block
        end
      end
    end
  end
end
