# frozen_string_literal: true

module ViewComponent
  module Storybook
    module MethodArgs
      class MethodParametersNames
        REQ_KWARG_TYPE = :keyreq
        KWARG_TYPES = [REQ_KWARG_TYPE, :key].freeze
        REQ_ARG_TYPE = :req
        ARG_TYPES = [REQ_ARG_TYPE, :opt].freeze
        KWARG_REST = :keyrest
        REST = :rest

        attr_reader :target_method

        def initialize(target_method)
          @target_method = target_method
        end

        def arg_name(pos)
          if pos < named_arg_count
            arg_names[pos]
          else
            offset_pos = pos - named_arg_count
            "#{rest_arg_name}#{offset_pos}".to_sym
          end
        end

        def include_kwarg?(kwarg_name)
          supports_keyrest? || kwarg_names.include?(kwarg_name)
        end

        def covers_required_kwargs?(names)
          names.to_set >= req_kwarg_names.to_set
        end

        def max_arg_count
          supports_rest? ? Float::INFINITY : named_arg_count
        end

        def min_arg_count
          req_arg_count
        end

        def req_kwarg_names
          @req_kwarg_names ||= parameters.map do |type, name|
            name if type == REQ_KWARG_TYPE
          end.compact
        end

        private

        def parameters
          @parameters ||= target_method.parameters
        end

        def kwarg_names
          @kwarg_names ||= parameters.map do |type, name|
            name if KWARG_TYPES.include?(type)
          end.compact
        end

        def arg_names
          @arg_names ||= parameters.map do |type, name|
            name if ARG_TYPES.include?(type)
          end.compact
        end

        def req_arg_names
          @req_arg_names ||= parameters.map do |type, name|
            name if type == REQ_ARG_TYPE
          end.compact
        end

        def named_arg_count
          @named_arg_count ||= arg_names.count
        end

        def req_arg_count
          @req_arg_count ||= req_arg_names.count
        end

        def rest_arg_name
          @rest_arg_name ||= parameters.map { |type, name| name if type == REST }.first
        end

        def supports_keyrest?
          @supports_keyrest ||= parameters.map(&:first).include?(KWARG_REST)
        end

        def supports_rest?
          @supports_rest ||= parameters.map(&:first).include?(REST)
        end
      end
    end
  end
end
