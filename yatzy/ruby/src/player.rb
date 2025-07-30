# frozen_string_literal: true

require_relative 'scorecard'

class Player
  attr_reader :scorecard, :name
  attr_accessor :sum

  def initialize(name:)
    @name = name
    @scorecard = Scorecard.new
    @sum = 0
  end
end
