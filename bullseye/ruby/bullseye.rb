class Player
    attr_reader :name

    def initialize(name)
        @name = name
        @score = 0
    end

    def name()
        @name
    end

    def add(value)
        @score += value
    end

    def points()
        @score
    end

    def reset
        @score = 0
    end
end


class Throw
    def initialize()
        $fast = [0.65, 0.55, 0.5, 0.5]
        $controlled = [0.99, 0.77, 0.43, 0.01]
        $underarm = [0.95, 0.75, 0.45, 0.05]
        $points = [40, 30, 20, 10, 0]
        $moves = {"1" => $fast, "2" => $controlled, "3" => $underarm}
    end

    def hit(array)
        random = rand
        array.each_with_index do |point, number|
            if random >= point
                place = array.find_index(point)
                return $points[place]
            elsif number == 3
                return 0
            end
        end
    end
end


class Game
    def initialize()
        @throw = Throw.new()
        @players = []

        puts "\nThe objective of the game is to get 200 points to win"
        puts "\n1 - Fast Overarm - Bullseye or nothing"
        puts "2 - Controlled Overarm - 10, 20 or 30 points"
        puts "3 - Underarm - Anything"

        puts "\nNumber of Players: "
        players = gets.chomp.to_i

        players.times do |idx|
            puts "\nPlayer #{idx+1}'s name:"
            name = gets.chomp
            @players << Player.new(name)
        end
    end

    def round()
        @players.each do |player|
            puts "\n\n#{player.name}'s turn!"

            loop do
                puts "\nWhat is your move:"
                move = gets.chomp

                if $moves.include?(move)
                    points = @throw.hit($moves[move])
                    player.add(points)

                    if points == 0
                        puts "\nYou missed the target!"
                    elsif points == 40
                        puts "\nBullseye! You hit the #{points}-point zone!"
                    else
                        puts "\nYou hit the #{points}-point zone!"
                    end
                    puts "Your total is now #{player.points} points!"

                    if player.points >= 200
                        result(player)
                        exit
                    end

                    break
                end
            end

        end
        round
    end

    def result(winner)
        puts "\n#{winner.name} won the game!\nResult of all the players:\n\n"

        @players.each do |player|
            puts "#{player.name}: #{player.points}"
            player.reset
        end

        loop do
            puts "Play again? y/n"
            choice = gets.chomp.downcase

            if %q[y yes].include?(choice)
                round
                break
            elsif %q[n no].include?(coice)
                exit
            end
        end
    end
end

game = Game.new
game.round