# frozen_string_literal: true

require 'bundler/setup'
require_relative 'player'

class Game
  def initialize
    @players = []
    (1..gets.chomp.to_i).each do |_|
      player = Player.new(name: gets.chomp)
      puts player.scorecard.display
      @players << player
    end
  end
end

Game.new
