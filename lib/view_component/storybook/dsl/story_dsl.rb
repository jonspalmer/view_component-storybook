# frozen_string_literal: true

module ViewComponent
  module Storybook
    module Dsl
      class StoryDsl
        def self.evaluate!(story_config, &block)
          new(story_config).instance_eval(&block)
        end

        def parameters(**params)
          @story_config.parameters = params
        end

        def knobs(&block)
          knobs_dsl = KnobsDsl.new(story_config.component)
          knobs_dsl.instance_eval(&block)
          @story_config.knobs = knobs_dsl.knobs
        end

        def layout(layout)
          @story_config.layout = layout
        end

        def content(&block)
          @story_config.content_block = block
        end

        private

        attr_reader :story_config

        def initialize(story_config)
          @story_config = story_config
        end
      end
    end
  end
end
