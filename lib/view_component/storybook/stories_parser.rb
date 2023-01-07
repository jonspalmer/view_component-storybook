require "yard"

module ViewComponent
  module Storybook
    class StoriesParser
      def initialize(paths, tags = nil)
        @paths = paths
        @after_parse_callbacks = []
        @after_parse_once_callbacks = []
        @parsing = false

        define_tags(tags)
        YARD::Parser::SourceParser.after_parse_list { run_callbacks }
      end

      def parse(&block)
        unless @parsing
          @parsing = true
          @after_parse_once_callbacks << block if block
          YARD::Registry.clear
          YARD.parse(paths)
        end
      end

      def after_parse(&block)
        @after_parse_callbacks << block
      end

      def paths
        @paths
        # PathUtils.normalize_paths(@paths).map { |path| "#{path}/**/*preview.rb" }
      end

      protected

      def callbacks
        [
          *@after_parse_callbacks,
          *@after_parse_once_callbacks
        ]
      end

      def run_callbacks
        callbacks.each { |cb| cb.call(YARD::Registry) }
        @after_parse_once_callbacks = []
        @parsing = false
      end

      def define_tags(tags = nil)
        # tags.to_h.each do |name, tag|
        #   YARD::Tags::Library.define_tag(tag[:label], name, Lookbook::TagProvider)
        # end
      end
    end
  end
end