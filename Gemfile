# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in viewcomponent-storybook.gemspec
gemspec

rails_version = (ENV["RAILS_VERSION"] || "6.0.0").to_s

gem "rails", rails_version == "master" ? { github: "rails/rails" } : rails_version
