# frozen_string_literal: true

require 'bundler/setup'
require_relative 'dice'
require_relative 'player'

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
    puts "\n#{player.name}'s turn!"
    player.scorecard.display
    dice = Dice.new
    dice.display
    2.times do
      puts 'Choose dice to reroll or skip w/ s'
      input = gets.chomp
      next if input == 's'

      input.gsub("/\D/", '').chars.map { |idx| dice.reroll(idx.to_i) }
      dice.display
    end
  end
end

Game.new.round
