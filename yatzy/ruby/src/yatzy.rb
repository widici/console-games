# frozen_string_literal: true

require 'bundler/setup'
require_relative 'player'
require_relative 'dice'

class Game
  def initialize
    @players = []
    puts 'How many players?: '
    (1..gets.chomp.to_i).each do |n|
      puts "#{n}th player's name: "
      player = Player.new(name: gets.chomp)
      @players << player
    end
  end

  def round
    @players.each do |player|
      turn(player)
    end
  end

  def turn(player)
    puts "#{player.name}'s turn!"
    puts 'Scorecard:'
    player.scorecard.display
  end
end

Game.new.round
