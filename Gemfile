# frozen_string_literal: true

source "https://rubygems.org"
gemspec

rails_version = (ENV["RAILS_VERSION"] || "6.0.3.3").to_s

gem "rails", rails_version == "main" ? { git: "https://github.com/rails/rails", ref: "main" } : rails_version
