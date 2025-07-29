# frozen_string_literal: true

require_relative 'scorecard'

class Player
  attr_reader :scorecard, :name

  def initialize(name:)
    @name = name
    @scorecard = Scorecard.new
  end
end
