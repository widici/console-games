use std::fmt::{Display, Formatter};
use crate::enums::{Colors, Values};
use crate::card::Card;
use strum::IntoEnumIterator;
use rand::thread_rng;
use rand::seq::SliceRandom;

#[derive(Clone)]
pub struct Deck {
    pub(crate) cards: Vec<Card>
}

impl Display for Deck {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        for card in 0..self.cards.len() {
            writeln!(f, "{} - {}", card, &self.cards[card])?;
        }
        Ok(())
    }
}


impl Default for Deck {
    fn default() -> Deck {
        let mut cards: Vec<Card> = Vec::with_capacity(108);

        (0..2).into_iter().for_each(|_| {
            Colors::iter().for_each(|color| {
                Values::iter().for_each(|value| {
                    let _ = cards.push(Card::new(value, color));
                });
            });
        });

        // Removes first set of WildCard, DrawFour, Zero
        let indexes: [usize; 4] = [0, 12, 24, 36];
        (0..=cards.len()).into_iter().for_each(|index| {
            if indexes.contains(&index) {
                (0..3).into_iter().for_each(|_| {
                    cards.remove(index);
                });
            }
        });

        cards.shuffle(&mut thread_rng());

        return Deck {cards}
    }
}

impl Deck {
    pub fn new() -> Deck {
        let cards: Vec<Card> = Vec::with_capacity(108);
        return Deck {cards}
    }

    pub fn draw(&mut self, deck: &mut Deck, amount: usize) {
        let mut drawn = deck.cards.split_off(deck.cards.len() - amount);
        self.cards.append(&mut drawn);
    }
}