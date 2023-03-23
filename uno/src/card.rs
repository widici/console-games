use crate::enums::{Colors, Values};
use std::fmt::{Display, Formatter};

#[derive(Copy, Clone)]
pub struct Card {
    pub(crate) value: Values,
    pub(crate) color: Colors,
}

impl Display for Card {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        match &self.value {
            Values::WildCard => write!(f, "{:?} Wild Card", &self.color),
            Values::DrawFour => write!(f, "{:?} Draw Four", &self.color),
            Values::DrawTwo => write!(f, "{:?} Draw Two", &self.color),
            _ => write!(f, "{:?} {:?}", &self.color, &self.value),
        }
    }
}

impl PartialEq for Card {
    fn eq(&self, other: &Self) -> bool {
        [Values::DrawFour, Values::WildCard, other.value].contains(&self.value) || self.color == other.color
    }
}

impl Card {
    pub fn new(value: Values, color: Colors) -> Card {
        return Card { value, color }
    }
}