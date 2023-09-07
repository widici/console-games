class Deck
    def initialize
        @cards = [] of Card
        
        Suit.values.each do |suit|
            (2..14).each do |rank|
                card = Card.new(suit, rank)
                @cards << card
            end
        end
        @cards.shuffle!
    end

    def draw
        if @cards.empty?
            initialize 
        end
        @cards.pop()
    end
end    