# frozen_string_literal: true

module ViewComponent
  module Storybook
    class ParametersCollection
      def initialize
        @all_paramsters = {}
        @parameters = []
      end

      def add(params, only: nil, except: nil)
        if only.nil? && except.nil?
          all_paramsters.merge!(params)
        else
          parameters << { params: params, only: only, except: except }
        end
      end

      # Parameters set for all stories
      def for_all
        all_paramsters
      end

      # Parameters set for the story method
      def for_story(story_name)
        parameters.each_with_object({}) do |opts, accum|
          accum.merge!(opts[:params]) if valid_for_story?(story_name, opts.slice(:only, :except))
        end
      end

      private

      attr_reader :all_paramsters, :parameters

      def valid_for_story?(story_name, only:, except:)
        (only.nil? || Array.wrap(only).include?(story_name)) && Array.wrap(except).exclude?(story_name)
      end
    end
  end
end
