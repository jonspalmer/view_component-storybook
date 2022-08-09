# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Slots
      class SlotConfig
        include ActiveModel::Validations
        include ContentConcern

        attr_reader :slot_name, :slot_method_args, :param, :content_block

        validate :validate_slot_method_args

        def initialize(slot_name, slot_method_args, param, content_block)
          @slot_name = slot_name
          @slot_method_args = slot_method_args
          @param = param
          @content_block = content_block
        end

        def self.from_component(component_class, slot_name, param, *args, **kwargs, &block)
          new(
            slot_name,
            slot_method_args(component_class, slot_name, *args, **kwargs).with_param_prefix(param),
            param,
            block
          )
        end

        def slot(component, params)
          resolved_method_args = slot_method_args.resolve_method_args(params)
          story_content_block = resolve_content_block(params)
          Slot.new(component, slot_name, resolved_method_args, story_content_block)
        end

        def controls
          list = slot_method_args.controls.dup
          list << content_control if content_control
          list
        end

        def content_param
          "#{param}__content".to_sym
        end

        private

        def validate_slot_method_args
          return if slot_method_args.valid?

          slot_method_args_errors = slot_method_args.errors.full_messages.join(', ')
          errors.add(:slot_method_args, :invalid, errors: slot_method_args_errors)
        end

        def self.slot_method_args(component_class, slot_name, *args, **kwargs)
          # Reverse engineer the signature of the slot so that we can validate control args to the slot
          # The slot methods themselves just have rest params so we can't introspect them. Instead we
          # look for 'renderable' details of the registered slot
          # This approach is tightly coupled to internal ViewCopmonent apis and might prove to be brittle
          registred_slot_name = component_class.slot_type(slot_name) == :collection_item ? ActiveSupport::Inflector.pluralize(slot_name).to_sym : slot_name

          registered_slot = component_class.registered_slots[registred_slot_name]

          if registered_slot[:renderable] || registered_slot[:renderable_class_name]
            # The slot is a component - either a class or a string representing the class
            component_class = registered_slot[:renderable] || component_class.const_get(registered_slot[:renderable_class_name])
            MethodArgs::ComponentConstructorArgs.from_component_class(component_class, *args, **kwargs)
          else
            # the slot is a lamba or a simple content slot
            slot_lamba = registered_slot[:renderable_function] || proc {}
            MethodArgs::ControlMethodArgs.new(slot_lamba, *args, **kwargs)
          end
        end

        private_class_method :slot_method_args
      end
    end
  end
end
