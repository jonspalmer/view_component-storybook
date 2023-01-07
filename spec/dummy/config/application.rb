# frozen_string_literal: true

require File.expand_path('boot', __dir__)

require "active_model/railtie"
require "action_controller/railtie"
require "action_view/railtie"
require "sprockets/railtie"

require "view_component"
require "view_component/storybook"

module Dummy
  class Application < Rails::Application
    config.secret_key_base = "foo"

    # config.view_component.preview_paths << Rails.root.join("test/components/stories")
  end
end
