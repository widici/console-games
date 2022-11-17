class Player
    attr_reader :name

    def initialize(name)
        @name = name
        @score = 0
    end
end


class Throw
    def initialize()
        $fast = [0.65, 0.55, 0.5, 0.5]
        $controlled = [0.99, 0.77, 0.43, 0.01]
        $underarm = [0.95, 0.75, 0.45, 0.05]
        @points = [40, 30, 20, 10, 0]
    end

    def hit(array)
        random = rand
        array.each_with_index do |point, number|
            if random >= point
                place = array.find_index(point)
                return @points[place]
            elsif number == 3
                return 4
            end
        end
    end
end

throw = Throw.new()
puts throw.hit($fast)