# frozen_string_literal: true

require 'dry-initializer'

class DryComponent < ViewComponent::Base
  extend Dry::Initializer

  param :title
  option :message, optional: false
end
