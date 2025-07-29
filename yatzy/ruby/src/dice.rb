# frozen_string_literal: true

class Dice
  def initialize
    @value = rand(1..6)
  end

  def display
    rows = ['┌─────────┐']
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
      ][@value - 1].map { |line| "|#{line}|" }
    )
    rows << '└─────────┘'
    puts rows
  end
end
