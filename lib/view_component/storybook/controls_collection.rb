# frozen_string_literal: true

module ViewComponent
  module Storybook
    class ControlsCollection
      attr_reader :controls

      attr_accessor :code_object

      def initialize
        @controls = []
      end

      def add(param, as:, only: nil, except: nil, **opts)
        controls << { param: param, as: as, only: Array.wrap(only), except: Array.wrap(except), **opts }
      end

      def for_story(story_name)
        # build the controls for the story_name
        # pass through a hash to get the last valid control declared for each param
        controls.map do |opts|
          next unless valid_for_story?(story_name, opts.slice(:only, :except))

          param = opts[:param]
          unless opts.key?(:default)
            opts = opts.merge(default: parse_default(story_name, param))
          end
          [param, build_control(param, **opts)]
        end.compact.to_h.values
      end

      private

      def valid_for_story?(story_name, only:, except:)
        (only.empty? || only.include?(story_name)) && (except.empty? || !except.include?(story_name))
      end

      def parse_default(story_name, param)
        code_method = code_object.meths.find { |m| m.name == story_name }
        default_value_parts = code_method.parameters.find { |parts| parts[0].chomp(":") == param.to_s }
        if default_value_parts
          code_method.instance_eval(default_value_parts[1])
        end
      end

      def build_control(param, as:, **opts)
        case as
        when :text
          Controls::Text.new(param, **opts)
        when :boolean
          Controls::Boolean.new(param, **opts)
        when :number
          Controls::Number.new(param, type: :number, **opts)
        when :range
          Controls::Number.new(param, type: :range, **opts)
        when :color
          Controls::Color.new(param, **opts)
        when :object, :array
          Controls::Object.new(param, **opts)
        when :select
          Controls::Options.new(param, type: :select, **opts)
        when :multi_select
          Controls::MultiOptions.new(param, type: :'multi-select', **opts)
        when :radio
          Controls::Options.new(param, type: :radio, **opts)
        when :inline_radio
          Controls::Options.new(param, type: :'inline-radio', **opts)
        when :check
          Controls::MultiOptions.new(param, type: :check, **opts)
        when :inline_check
          Controls::MultiOptions.new(param, type: :'inline-check', **opts)
        when :date
          Controls::Date.new(param, **opts)
        else
          raise "Unknonwn control type '#{as}'"
        end
      end
    end
  end
end
