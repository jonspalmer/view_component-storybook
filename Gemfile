# frozen_string_literal: true

source "https://rubygems.org"
gemspec

rails_version = (ENV["RAILS_VERSION"] || "6.0.3.3").to_s

gem "rails", rails_version == "master" ? { github: "rails/rails" } : rails_version
