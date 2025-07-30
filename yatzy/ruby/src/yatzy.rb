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

  def run
    (Scorecard::FIELDS.size - 1).times do |_|
      @players.each do |player|
        turn(player)
      end
    end
    @players.each do |player|
      puts "#{player.name}'s final scorecard: "
      player.scorecard.display
      sum = ((0..5).to_a + (7..15).to_a).map { |idx| player.scorecard.get_score(idx) }
                                        .sum
      if sum >= 63
        player.scorecard.set_score(6, 50) if sum >= 63
        sum += 50
      end
      player.sum = sum
    end
    winner = @players.max_by(&:sum)
    puts "#{winner.name} won with #{winner.sum} points!"
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

      input.gsub("/\D/", '').chars.map { |n| dice.reroll(n.to_i - 1) }
      dice.display
    end
    puts 'Do you want to fill or zero a category (f/z)?: '
    idx = gets.chomp
    if %w[z zero].include? idx
      zero_cat(player)
    elsif %w[f fill].include? idx
      fill_cat(player, dice)
    end
  end

  def zero_cat(player)
    puts 'Enter id of category: '
    idx = gets.chomp.to_i - 1
    return zero_cat player if idx == 6

    player.scorecard.set_status(idx, Status::ZEROED)
  end

  def fill_cat(player, dice)
    puts 'Enter id of category: '
    idx = gets.chomp.to_i - 1
    score =
      case Scorecard::FIELDS[idx]
      when *Scorecard::UPPER_FIELDS
        dice.get_upper(idx)
      when :pair, :three_kind, :four_kind
        dice.get_kind(idx - 5)
      when :two_pair
        dice.get_two_pair
      when :full_house
        dice.get_full_house
      when :small_st
        dice.get_st(1..5)
      when :large_st
        dice.get_st(2..6)
      when :chance
        dice.sum
      when :yatzy
        dice.get_yatzy
      else
        return fill_cat(player, dice)
      end

    return fill_cat(player, dice) if score.zero? || player.scorecard.get_score(idx) != 0

    player.scorecard.set_score(idx, score)
  end
end

Game.new.run
