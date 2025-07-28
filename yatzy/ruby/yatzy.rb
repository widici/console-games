# frozen_string_literal: true

class Game
  def initialize
    @players = []

    (1..gets.chomp.to_i).each do |n|
      Player.new(name: gets.chomp, id: n) >> @players
    end
  end
end
