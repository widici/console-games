use crate::deck::Deck;
use std::fmt::{Display, Formatter};

#[derive(Clone)]
pub struct Player {
    pub(crate) name: String,
    pub(crate) hand: Deck,
}

impl Display for Player {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
       return write!(f, "{}", self.hand)
    }
}

impl Player {
    pub fn new(name: String) -> Player {
        let hand = Deck::new();
        return Player { name, hand };
    }
}