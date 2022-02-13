# frozen_string_literal: true

source "https://rubygems.org"
gemspec

rails_version = (ENV["RAILS_VERSION"] || "6.1.4.6").to_s

gem "rails", rails_version == "main" ? { git: "https://github.com/rails/rails", ref: "main" } : rails_version
