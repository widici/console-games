class Game
    def initialize()
        @@score = 0
        @secret = rand(102...987).to_s while @secret.to_s.split("").uniq.size < 3
        @rounds = 0
        @out = ""
    end

    def round()
        puts "\nWhat do you think the number is? (#{20 - @rounds} guesses remaining)"
        guess = gets.chomp

        if guess.split("").uniq.size < 3 or guess.split("").size > 3
            puts "Guess needs to be three diffrent number!"
            round
        end

        guess.split("").each do |element|
            if element == @secret.split("")[(guess.index(element))]
                @out += "Fermi "
            elsif @secret.split("").include?(element)
                @out += "Pico "
            end
        end

        if @secret == guess
            @out = ""
            @@score += 1
            end_round("You guessed the right number #{@secret}!")
        elsif @out == ""
            @out = "Bagels "
        end

        puts "#{@out}"
        @out = ""

        if @rounds >= 20
            @out = ""
            end_round("You exceeded the number of guesses and didn't guess the right number #{@secret}!")
        end

        @rounds += 1
        round
    end

    def end_round(message)
        puts "\n#{message}\nScore: #{@@score}\nGuesses: #{@rounds}"
        puts "Whould you like to play again? (y/n)"
        choice = gets.chomp.downcase

        if %q[y yes].include?(choice)
            game = Game.new
            game.round
        elsif %q[n no].include?(choice)
            exit
        else
            end_round
        end
    end
end

game = Game.new
game.round