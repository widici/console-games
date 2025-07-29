# frozen_string_literal: true

require 'table_tennis'

module Status
  UNFILLED = :UNFILLED
  FILLED = :FILLED
  ZEROED = :ZEROED
  public_constant :FILLED, :UNFILLED, :ZEROED
end

class Field
  attr_reader :status, :score

  def initialize
    @status = ::Status::UNFILLED
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
    (UPPER_FIELDS + LOWER_FIELDS).each_with_index do |name, idx|
      field = instance_variable_get("@#{name}")
      status =
        case field.status
        when ::Status::UNFILLED
          '__'
        when ::Status::FILLED
          field.score.to_s
        when ::Status::ZEROED
          'x'
        else
          abort
        end
      rows << [idx.to_s, name.to_s.sub('_', ' ').capitalize, status]
    end
    TableTennis.new(rows, { title: 'Scorecard', headers: { '0': 'Id', '1': 'Category', '2': 'Status' } }).render
  end
end
