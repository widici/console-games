$values = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"]

class Card
    attr_reader :value, :suit

    def initialize(value, suit)
        @value = value
        @suit = suit
    end

    def show()
        "#{self.value}#{self.suit}"
    end
end


class Deck
    def initialize()
        @cards = []

        ["\u2665", "\u2666", "\u2663", "\u2660"].each do |suit|
             $values.each do |value|
                @cards << Card.new(value, suit)
            end
        end
        @cards.shuffle!
    end


    def draw()
        @cards.pop
    end
end


class Player
    attr_reader :name

    def initialize(name)
        @balance = 100
        @name = name
    end

    def balance()
        @balance
    end

    def name()
        @name
    end
end


class Game
    def initialize
        @players = []
        @deck = Deck.new

        puts "Number of players: "
        choice = gets.chomp.to_i

        choice.times do 
            puts "\nPlayer name: "
            name = gets.chomp
            @players << Player.new(name)
        end
    end

    def round()
        @players.each do |player|
            puts "\n#{player.name}'s turn!"
            card_a, card_b = @deck.draw, @deck.draw
            puts "\n#{card_a.show} ? #{card_b.show}"

            loop do
                puts "\nYou have $#{player.balance}.\nHow much would you like to bet?"
                bet = gets.chomp.to_i

                if bet <= player.balance and bet > 0
                    break
                end
                puts "\nInvalid input!"
            end
        end
    end

    def show()
        @players.each do |player|
            puts "\n#{player.name} | #{player.balance}"

        end
    end
end

game = Game.new
game.round
