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
    round
  end

  def turn(player)
    puts "\n#{player.name}'s turn!"
    player.scorecard.display
    dice = Dice.new
    dice.display
    2.times do
      puts 'Choose dice to reroll or skip w/ s'
      input = gets.chomp
      break if input == 's'

      input.gsub("/\D/", '').chars.map { |idx| dice.reroll(idx.to_i) }
      dice.display
    end
    puts 'Do you want to fill or zero a category (f/z)?: '
    input = gets.chomp
    if %w[z zero].include? input
      zero_cat(player)
    elsif %w[f fill].include? input
      fill_cat(player, dice)
    end
  end

  def zero_cat(player)
    puts 'Enter id of category: '
    player.scorecard.set_status(gets.chomp.to_i, Status::ZEROED)
  end

  def fill_cat(player, dice); end
end

Game.new.round
