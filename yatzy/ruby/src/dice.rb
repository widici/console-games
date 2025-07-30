# frozen_string_literal: true

class Die
  attr_accessor :value

  def initialize
    @value = rand(1..6)
  end

  def display
    rows = ['╭─────────╮']
    rows.push(
      *[
        [
          '         ',
          '    ●    ',
          '         '
        ],
        [
          '  ●      ',
          '         ',
          '      ●  '
        ],
        [
          '  ●      ',
          '    ●    ',
          '      ●  '
        ],
        [
          '  ●   ●  ',
          '         ',
          '  ●   ●  '
        ],
        [
          '  ●   ●  ',
          '    ●    ',
          '  ●   ●  '
        ],
        [
          '  ●   ●  ',
          '  ●   ●  ',
          '  ●   ●  '
        ]
      ][@value - 1].map { |line| "│#{line}│" }
    )
    rows << '╰─────────╯'
    rows
  end
end

class Dice
  def initialize
    @dice = 5.times.map { Die.new }
  end

  def display
    puts(@dice.map(&:display).transpose.map { |group| group.join ' ' })
    puts (' ' * 5) + (1..5).map(&:to_s).join(' ' * 11)
  end

  def reroll(idx)
    @dice[idx] = Die.new
  end

  # Get score for upper category
  def get_upper(idx)
    @dice.select { |dice| dice.value == idx + 1 }
         .map(&:value)
         .sum
  end

  # Get group of dice showing amount
  # E.g.: @dice = [1, 1, 2, 3, 4] & amount = 1 -> [1, 1]
  def get_groups(amount)
    @dice.map(&:value).group_by { |x| x }
         .values.select { |group| group.size == amount }
  end

  # Get score for x of a kind
  def get_kind(x)
    get_groups(x)
      .map(&:sum)
      .max || 0
  end

  def get_full_house
    a, b = get_kind(2), get_kind(3)
    return 0 if a.zero? || b.zero?

    a + b
  end

  def get_two_pair
    pairs = get_groups(2)
    return 0 if pairs.size != 2

    pairs.map(&:sum).max
  end

  def get_st(range)
    if range.all? { |x| @dice.value.contains(x) }
      range.sum
    else
      0
    end
  end

  def get_yatzy
    return 50 if get_kind(5) != 0

    0
  end
end
