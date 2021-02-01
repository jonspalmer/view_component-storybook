# frozen_string_literal: true

class KwargsComponent < ViewComponent::Base
  attr_reader :message

  def initialize(**kwargs)
    @message = kwargs[:message]
  end
end
