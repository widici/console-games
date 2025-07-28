# frozen_string_literal: true

require_relative 'scorecard'

class Player
  attr_reader :scorecard

  def initialize(name:)
    @name = name
    @scorecard = Scorecard.new
  end
end
