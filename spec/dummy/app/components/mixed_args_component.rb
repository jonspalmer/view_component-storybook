# frozen_string_literal: true

class MixedArgsComponent < ViewComponent::Base
  attr_reader :title, :message

  def initialize(title, message:)
    super
    @title = title
    @message = message
  end
end
