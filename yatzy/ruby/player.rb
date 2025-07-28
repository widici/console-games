# frozen_string_literal: true

require_relative 'scorecard'

class Player
  def initialize(name:)
    @name = name
    @scorecard = Scorecard.new
  end
end
