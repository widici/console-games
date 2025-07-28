# frozen_string_literal: true

require_relative 'player'

class Game
  def initialize
    @players = []
    (1..gets.chomp.to_i).each do |_|
      @players << Player.new(name: gets.chomp)
    end
  end
end

Game.new
