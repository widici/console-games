# This is used instead of Participant.@@best since the super-class @@best isn't shared between sub-classes
module BestScore
    @@best : Int32 = 0

    def self.best
        @@best
    end

    def self.best=(score)
        @@best = score
    end
end

class Participant
    def initialize(@name : String)
        @total = Int32.new(0)
    end

    def turn
    end

    def set_best
        BestScore.best = @total
    end

    def add(amount : Int32)
        @total += amount
    end

    def to_s
        @name
    end
end

class Player < Participant
    def turn
        puts "h - hit, s - stand | total: #{@total}, best: #{BestScore.best}"
        return case (gets || "").downcase
        when "h", "hit"
            TurnAction::Hit
        when "s", "stand"
            TurnAction::Stand
        else
            puts "Invalid input!"
            turn
        end
    end
end

class Dealer < Participant
    def turn
        sleep 1

        if @total == 0 || (@total < BestScore.best && @total < 21)
          return TurnAction::Hit
        else
          return TurnAction::Stand
        end
    end
end

enum TurnAction
    Hit
    Stand
end