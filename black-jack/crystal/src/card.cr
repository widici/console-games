enum Suit
    Spades
    Hearts
    Diamonds
    Clubs
end

struct Card
    def initialize(@suit : Suit, @rank : Int32)
    end

    def to_s
        dsp_rank = case @rank
        when 11
            "Jack"
        when 12
            "Queen"
        when 13
            "King"
        when 14
            "Ace"
        else
            @rank.to_s
        end

        "#{dsp_rank} of #{@suit}"
    end  
end
