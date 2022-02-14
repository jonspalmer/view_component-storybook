# frozen_string_literal: true

require "bundler/setup"

# Configure Rails Envinronment
# we need to do this before including capybara
ENV["RAILS_ENV"] = "test"
require File.expand_path("dummy/config/environment.rb", __dir__)

ActiveSupport::Deprecation.silenced = true

require "rspec/expectations"
require "rspec/rails"
require 'capybara/rspec'

RSpec.configure do |config|
  config.include Capybara::RSpecMatchers, type: :request
end

require 'simplecov'
SimpleCov.start do
  command_name "rails#{ENV['RAILS_VERSION']}-ruby#{ENV['RUBY_VERSION']}" if ENV["RUBY_VERSION"]
  add_filter 'spec'
end

Dir[File.expand_path(File.join(File.dirname(__FILE__), "support", "**", "*.rb"))].sort.each { |f| require f }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!
  config.filter_rails_from_backtrace!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include RSpec::Rails::RequestExampleGroup, type: :request
end
