# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Slots
      class SlotConfig
        include WithContent

        attr_reader :slot_name, :slot_method_args, :param, :content_block

        def initialize(slot_name, slot_method_args, param, content_block)
          @slot_name = slot_name
          @slot_method_args = slot_method_args
          @param = param
          @content_block = content_block
        end

        def self.from_component(component_class, slot_name, param, *args, **kwargs, &block)
          slot_method_args =
            MethodArgs::ControlMethodArgs
            .new(component_class.instance_method(slot_name), *args, **kwargs)
            .with_param_prefix(param)
          new(slot_name, slot_method_args, param, block)
        end

        def slot(componeont, params)
          resolved_method_args = slot_method_args.resolve_method_args(params)
          story_content_block = resolve_content_block(params)
          Slot.new(componeont, slot_name, resolved_method_args, story_content_block)
        end

        def controls
          list = slot_method_args.controls.dup
          list << content_control if content_control
          list
        end

        def content_param
          "#{param}__content".to_sym
        end
      end
    end
  end
end
