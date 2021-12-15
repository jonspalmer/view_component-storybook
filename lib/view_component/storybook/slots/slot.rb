# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Slots
      class Slot
        attr_reader :component, :slot_name, :slot_method_args, :content_block

        # delegate :args, :kwargs, :controls, to: :slot_method_args

        def initialize(component, slot_name, slot_method_args, content_block)
          @component = component
          @slot_name = slot_name
          @slot_method_args = slot_method_args
          @content_block = content_block
        end

        def call
          component.send(slot_name, *slot_method_args.args, **slot_method_args.kwargs, &content_block)
        end
      end
    end
  end
end
