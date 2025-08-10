# Yatzy

Yatzy is a dice game where the objective is to fill as many different categories as possible with as high scores as possible.

Different categories require different conditions (mostly) in the form of different combinations of dice. The game ends when all categories are either filled or zeroed and the player with the highest score in the end wins. Dice can also be rerolled twice per round if a player wants to.

The categories are the following:

| Category   | Condition  | Score                          |
|------------|--------------------------------|--------------------------------|
| Ones       | At least one 1                 | Sum of all 1s                  |
| Twos       | At least one 2                 | Sum of all 2s                  |
| Threes     | At least one 3                 | Sum of all 3s                  |
| Fours      | At least one 4                 | Sum of all 4s                  |
| Fives      | At least one 5                 | Sum of all 5s                  |
| Sixes      | At least one 6                 | Sum of all 6s                  |
| Bonus      | 63 or points on category 1-6   | 50                             |
| Pair       | At least one pair              | Sum of highest pair            |
| Three kind | Three dice with the same value | Sum of the three dice          |
| Four kind  | Four dice with the same value  | Sum of the four dice           |
| Two pair   | Two pairs                      | Sum of the two different pairs |
| Full house | One pair and one three kind    | Sum of three kind and pair     |
| Small st   | 1, 2, 3, 4, 5                  | Sum of dice (15)               |
| Large st   | 2, 3, 4, 5, 6                  | Sum of dice (20)               |
| Chance     | None                           | Sum of dice                    |
| Yatzy      | A five kind                    | 50                             |

## Resources

- [Wikipedia article](https://en.wikipedia.org/wiki/Yatzy)
- [Additional rule explaination](https://info.lite.games/en/support/solutions/articles/60000688821-yatzy-rules)

## Running

### Ruby

More than requiring [Ruby](https://www.ruby-lang.org/en/documentation/installation/) (& RubyGems) the program also require bundler, which can be installed like this:

```sh
gem install bundler
```

The Ruby implementation can then be ran like this:

```sh
bundle install
ruby src/yatzy.rb
```
