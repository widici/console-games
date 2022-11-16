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

    def get_value()
        return $values.find_index(self.value)
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

    def add(amount)
        @balance += amount
    end
end


class Game
    def initialize
        @players = []
        @deck = Deck.new

        puts "\nNumber of players: "
        choice = gets.chomp.to_i

        choice.times do |number|
            puts "\nPlayer #{number+1}'s name: "
            name = gets.chomp
            @players << Player.new(name)
        end
    end

    def round()
        @players.each do |player|
            puts "\n\n#{player.name}'s turn!"
            card_a, card_b, card_c = @deck.draw, @deck.draw, @deck.draw
            puts "\n#{card_a.show} ? #{card_b.show}"

            loop do
                puts "\nYou have $#{player.balance}.\nHow much would you like to bet?"
                $bet = gets.chomp.to_i

                if $bet <= player.balance and $bet >= 0
                    break
                end
                puts "Need $#{player.balance - $bet} more $ to bet $#{$bet}"
            end

            puts "\n#{card_a.show} #{card_c.show} #{card_b.show}"
            if card_c.get_value > card_a.get_value and card_c.get_value < card_b.get_value
                win(player)
            elsif card_c.get_value > card_b.get_value and card_c.get_value < card_a.get_value
                win(player)
            else
                puts "You lost! -$#{$bet}"
                player.add(-$bet)
            end

        end
        play_again
    end

    def win(player)
        puts "You won! +$#{$bet}"
        player.add($bet)
    end

    def play_again()     
        loop do
            puts "\nPlay again? y/n"
            choice = gets.chomp.downcase

            if ["y", "yes"].include?(choice)
                break
            elsif ["n", "no"].include?(choice)
                exit
            end
        end

        round
    end


    def show()
        @players.each do |player|
            puts "\n#{player.name} | #{player.balance}"

        end
    end
end

game = Game.new
game.round
