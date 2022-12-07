$values = %w[Ace Two Three Four Five Six Seven Eight Nine Ten Jack Queen King]


class Card
    attr_reader :value, :suit

    def initialize(value, suit)
        @value = value
        @suit = suit
    end

    def show()
        "#{self.value} of #{self.suit}"
    end

    def get_value(total)

        if %w[Jack Queen King].include?(self.value)
            return 10
        elsif self.value == "Ace"
            if total + 11 > 21
                return 1
            else
                return 11
            end
        else
            return $values.find_index(self.value) + 1
        end
    end
end


class Deck
    
    def initialize
        @cards = []

        %w[Spades Hearts Diamonds Clubs].each do |suit|
            $values.each do |value|
                card = Card.new(value, suit)
                @cards << card
            end
        end
        @cards.shuffle!
    end

    def draw()
        @cards.pop
    end
end

class Player
    def initialize
        @total = 0
    end

    def add(value)
        @total += value
    end

    def get_total
        @total
    end
end


class Game
    def initialize
        @user = Player.new()
        @dealer = Player.new()
        @deck = Deck.new()
    end

    def player_input()
        puts "\nH - Hit\nS - Stand"
        choice = gets.chomp.downcase
        if choice == "h"
            hit
        elsif choice == "s"
            puts "\nYou chose Stand!"
            stand
        else
            puts "Invalid input '#{choice}'!"
            player_input
        end
    end

    def hit()
        card = @deck.draw
        total = @user.get_total
        value = card.get_value(total)
        @user.add(value)
        puts "\nYou drew #{card.show}\nTotal: #{@user.get_total}"
        check("hit")
    end

    def stand()
        sleep 1
        card = @deck.draw
        total = @dealer.get_total
        value = card.get_value(total)
        @dealer.add(value)
        puts "\nDealer drew #{card.show}\nYour total: #{@user.get_total}\nDealer total: #{@dealer.get_total}"
        check("stand")
    end

    def check(prev)
        if @user.get_total > 21
            end_game("You Lose")
        elsif @dealer.get_total < 22 and @dealer.get_total > @user.get_total
            end_game("You Lose")
        elsif @dealer.get_total > 21
            end_game("You Win")
        elsif @dealer.get_total == 21 and @user.get_total == 21
            end_game("Tie")
        else
            if prev == "hit"
                player_input
            else
                stand
            end
        end
    end

    def end_game(result)
        puts "\n#{result}!\nPlay again? y/n"
        choice = gets.chomp.downcase

        if ["y", "yes"].include?(choice)
            new_game
        elsif ["n", "no"].include?(choice)
            exit
        else
            end_game("Invalid input '#{choice}'")
        end
    end
end  


def new_game
    game = Game.new()
    game.player_input
end

new_game