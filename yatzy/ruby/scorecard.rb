# frozen_string_literal: true

module State
  UNFILLED = :UNFILLED
  FILLED = :FILLED
  ZEROED = :ZEROED
end

class Field
  attr_reader :state, :score

  def initialize
    @state = State::UNFILLED
    @score = 0
  end
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

  attr_reader(*(UPPER_FIELDS + LOWER_FIELDS))

  def initialize
    (UPPER_FIELDS + LOWER_FIELDS).each do |field|
      instance_variable_set("@#{field}", Field.new)
    end
  end
end
