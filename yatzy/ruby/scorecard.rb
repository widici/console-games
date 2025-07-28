# frozen_string_literal: true

module State
  UNFILLED = :UNFILLED
  FILLED = :FILLED
  ZEROED = :ZEROED
end

class Scorecard
  UPPER_FIELDS = %i[ones twos threes fours fives sixes].freeze
  LOWER_FIELDS = %i[three_kind
                    four_kind
                    full
                    small_st
                    large_st
                    chance
                    yatzy].freeze

  attr_accessor(*(UPPER_FIELDS + LOWER_FIELDS))

  def initialize
    (UPPER_FIELDS + LOWER_FIELDS).each do |field|
      instance_variable_set("@#{field}", State::UNFILLED)
    end
  end
end
