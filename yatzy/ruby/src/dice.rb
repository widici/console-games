# frozen_string_literal: true

class Die
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
    puts (' ' * 5) + (0..4).map(&:to_s).join(' ' * 11)
  end

  def reroll(idx)
    @dice[idx] = Die.new
  end
end
