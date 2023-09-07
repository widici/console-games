class Game
    def initialize
        @deck = Deck.new
        @participants = [] of Participant

        puts "\nHow many participants will participate?: "
        (1..(gets || "1").to_i).each do |id|
            puts "What is your name player #{id}?: "
            @participants << Player.new(gets || "Player #{id}")
        end
        @participants << Dealer.new("Dealer")

        winners = run
        puts case winners.size == 1
        when true
            "\n#{winners.first.to_s} won!"
        when false
            "\nTie between: #{winners.map {|participant| participant.to_s }.join(", ")}!"
        end
        new_game?
    end

    def run
        leaders = [] of Participant
        @participants.each do |participant|
            round(participant)
            if participant.@total > 21
                next
            end

            if leaders.empty? || leaders.any? { |p| p.@total == participant.@total }
                if participant.is_a?(Dealer)
                    leaders = [] of Participant
                    leaders << participant
                else 
                    leaders << participant
                    participant.set_best
                end
            else if !leaders.any? { |p| p.@total > participant.@total }
                participant.set_best
                leaders = [] of Participant
                leaders << participant
            end
        end
        end

        return leaders
    end

    def new_game?
        puts " \nPlay again? (y/n)"
        choice = (gets || "").downcase
        case choice
        when "y", "yes"
            initialize
        when "n", "no"
            exit(0)
        else
            puts "Invalid input: #{choice}!"
            new_game?
        end
    end

    def round(participant)
        puts "\n#{participant.to_s}'s turn!"
        while true
            decision = participant.turn
            case decision
            when TurnAction::Hit
                card = @deck.draw
                puts "Drawed #{card.to_s}!"

                to_add = case card.@rank
                when 11..13
                    10
                when 14
                    case participant.@total + 11
                    when 11..21
                        11
                    else
                        1
                    end
                else
                    card.@rank
                end
                
                participant.add(to_add)
                if participant.@total > 21
                    puts "Busted!"
                    break
                end
            when TurnAction::Stand
                break
            end
        end
    end
end  