extern crate core;

mod enums;
mod card;
mod deck;
mod player;

use crate::enums::{Colors, Values, TurnResults};
use crate::card::Card;
use crate::deck::Deck;
use crate::player::Player;

use std::io::{Read, stdin, stdout, Write};
use clearscreen::clear;

struct Main {
    players: Vec<Player>,
    deck: Deck,
    pile: Card,
    winners: Vec<Player>,
}

impl Main {
    fn new() -> Main {
        let mut players: Vec<Player> = Vec::with_capacity(10);
        let mut deck = Deck::default();
        let pile: Card = deck.cards.pop().unwrap();
        let winners: Vec<Player> = Vec::with_capacity(10);

        println!("\nNumber of players: ");
        let mut input = String::new();
        stdin().read_line(&mut input).expect("Failed to read player amount input");

        if let Ok(num) = input.trim().parse::<i32>() {
            for i in 1..num + 1 {
                println!("\nPlayer {}'s name: ", i);
                let mut input = String::new();
                stdin().read_line(&mut input).expect("Failed to read name input");
                let input = input.trim().to_owned();

                let mut player = Player::new(input);
                player.hand.draw(&mut deck, 7);
                let _ = &players.push(player);
            }
        } else if let Err(_) = input.trim().parse::<i32>() {
            return Main::new()
        }

        clear().unwrap();
        return Main { players, deck, pile, winners}
    }

    fn round(mut self) {
        let _ = &self.uno_players();

        let player = self.players.first_mut().unwrap();
        println!("{}'s turn\n{}Draw - Draw Card\n\n{}", player.name, player, &self.pile);
        let mut input = String::new();
        stdin().read_line(&mut input).expect("Failed to read card selection");

        match self.valid_card(input.clone()) {
            TurnResults::Valid => {
                let num = input.trim().parse::<i32>().unwrap();
                let card = self.players.first_mut().unwrap().hand.cards[num as usize];
                self.pile = card;
                self.play_card(num as usize, card);
                clear().unwrap();
                self.pause();
            }
            TurnResults::Draw => {
                if self.deck.cards.len() == 0 {
                    self.deck = Deck::default();
                }
                
                self.players.first_mut().unwrap().hand.draw(&mut self.deck, 1);
            }
            TurnResults::BadArg => {}
            TurnResults::PlayerFinish => {
                let winner = self.players.remove(0);
                self.winners.insert(self.winners.len(), winner)
            }
            TurnResults::GameFinish => {
                for _ in 0..2 {
                    let winner = self.players.remove(0);
                    self.winners.insert(self.winners.len(), winner)
                }
                self.finish()
            }
        }

        clear().unwrap();
        self.round()

    }

    fn uno_players(&self) {
        for player in &self.players {
            if player.hand.cards.len() == 1 {
                println!("{} has uno!", player.name)
            }
        }
    }

    fn valid_card(&mut self, input: String) -> TurnResults {
        let player: &Player = self.players.first().unwrap();

        return if let Ok(num) = input.trim().parse::<i32>() { // Successful cases
            let card = player.hand.cards[num as usize];

            if card == self.pile && player.hand.cards.len() == 1 {
                return if self.players.len() == 2 {
                    TurnResults::GameFinish
                } else { TurnResults::PlayerFinish }
            }

            if card == self.pile {
                TurnResults::Valid
            } else { TurnResults::BadArg }
        } else if input.trim().parse::<i32>().is_err() { // Unsuccessful cases
            if ["d", "draw"].contains(&&*input.trim().to_lowercase()) {
                TurnResults::Draw
            } else { TurnResults::BadArg }
        } else {
            TurnResults::BadArg
        }
    }

    fn pause(&self) {
        let mut stdout = stdout();
        stdout.write(b"Press [ENTER] to continue").unwrap();
        stdout.flush().unwrap();
        stdin().read(&mut [0]).unwrap();
    }

    fn play_card(&mut self, num: usize, card: Card) {
        let players: &mut Vec<Player> = &mut self.players;
        let player: &mut Player = players.first_mut().unwrap();
        player.hand.cards.remove(num as usize);

        match card.value {
            Values::Reverse => {
                let _ = players.reverse();
                let last = players.pop().unwrap();
                players.insert(0, last);
            },
            Values::Block => {
                self.first_to_last();
            },
            Values::DrawTwo => {
                players.get_mut(1).unwrap().hand.draw(&mut self.deck, 2)
            },
            Values::DrawFour => { players.get_mut(1).unwrap().hand.draw(&mut self.deck, 4);
                self.color_card();
            },
            Values::WildCard => {
                self.color_card();
            },
            _ => {},
        }

        self.first_to_last();
    }

    fn color_card(&mut self) {
        println!("\n0 - Green\n1 - Red\n2 - Blue\n3 - Yellow");
        let mut input = String::new();
        stdin().read_line(&mut input).expect("Failed to color selection");

        if let Ok(num) = input.trim().parse::<i32>() {
            self.pile.color = match num {
                0 => { Colors::Green },
                1 => { Colors::Red },
                2 => { Colors::Blue },
                3 => { Colors::Yellow },
                _ => { return self.color_card() },
            };
        }
    }

    fn first_to_last(&mut self) {
        if let Some(first) = self.players.first().cloned() {
            self.players.remove(0);
            self.players.push(first);
        }
    }


    fn finish(&self) {
        for index in 0..self.winners.len() {
            let player: &Player = &self.winners[index];
            println!("{} {}", index+1, player.name)
        }
    }
}

fn play_again() {
    println!("\nPlay again? (y/n)");
    let mut input = String::new();
    stdin().read_line(&mut input).unwrap();

    if ["y", "yes"].contains(&input.trim()) {
        println!("@y");
        main()
    } else if ["no", "n"].contains(&input.trim()) {
        std::process::exit(1);
    } else {
        play_again()
    }
}

fn main() {
    let main = Main::new();
    main.pause();
    main.round();
    play_again();
}