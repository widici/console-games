# frozen_string_literal: true

require 'table_tennis'

module Status
  UNFILLED = :UNFILLED
  FILLED = :FILLED
  ZEROED = :ZEROED
  public_constant :FILLED, :UNFILLED, :ZEROED
end

class Field
  attr_accessor :status, :score

  def initialize
    @status = ::Status::UNFILLED
    @score = 0
  end
end

class Scorecard
  UPPER_FIELDS = %i[ones twos threes fours fives sixes].freeze
  LOWER_FIELDS = %i[bonus pair three_kind four_kind two_pair full_house small_st large_st chance yatzy].freeze
  FIELDS = UPPER_FIELDS + LOWER_FIELDS

  def initialize
    FIELDS.each do |field|
      instance_variable_set("@#{field}", Field.new)
    end
  end

  def set_status(idx, status)
    instance_variable_get("@#{FIELDS[idx]}").status = status
  end

  def get_score(idx)
    instance_variable_get("@#{FIELDS[idx]}").score
  end

  def set_score(idx, score)
    field = instance_variable_get("@#{FIELDS[idx]}")
    field.score = score
    field.status = ::Status::FILLED
  end

  def display
    rows = []
    FIELDS.each_with_index do |name, idx|
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
      rows << [(idx + 1).to_s, name.to_s.sub('_', ' ').capitalize, status]
    end
    TableTennis.new(rows, { title: 'Scorecard', headers: { '0': 'Id', '1': 'Category', '2': 'Status' } }).render
  end
end
