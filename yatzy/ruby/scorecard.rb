# frozen_string_literal: true

require 'table_tennis'

module State
  UNFILLED = :UNFILLED
  FILLED = :FILLED
  ZEROED = :ZEROED
  public_constant :FILLED, :UNFILLED, :ZEROED
end

class Field
  attr_reader :state, :score

  def initialize
    @state = ::State::UNFILLED
    @score = 0
  end
end

class Scorecard
  UPPER_FIELDS = %i[ones twos threes fours fives sixes].freeze
  LOWER_FIELDS = %i[three_kind four_kind full small_st large_st chance yatzy].freeze
  private_constant :UPPER_FIELDS, :LOWER_FIELDS

  attr_reader(*(UPPER_FIELDS + LOWER_FIELDS))

  def initialize
    (UPPER_FIELDS + LOWER_FIELDS).each do |field|
      instance_variable_set("@#{field}", Field.new)
    end
  end

  def display
    rows = []
    (UPPER_FIELDS + LOWER_FIELDS).each do |name|
      field = instance_variable_get("@#{name}")
      rows << [name.to_s.sub('_', ' ').capitalize, field.state.downcase.capitalize, field.score]
    end
    TableTennis.new(rows, { title: 'Scorecard', headers: { '0': 'Category', '1': 'State', '2': 'Score' } }).render
  end
end
