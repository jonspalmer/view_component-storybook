# frozen_string_literal: true

class ArgsComponent < ViewComponent::Base
  attr_reader :items

  def initialize(*items)
    super
    @items = items
  end
end
