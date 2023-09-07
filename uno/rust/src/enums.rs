use strum_macros::EnumIter;

#[derive(Debug, EnumIter, Clone, Copy, PartialEq)]
pub enum Values {
    Zero,
    DrawFour,
    WildCard,
    One,
    Two,
    Three,
    Four,
    Five,
    Six,
    Seven,
    Eight,
    Nine,
    Reverse,
    Block,
    DrawTwo,
}

#[derive(Debug, EnumIter, Clone, Copy, PartialEq)]
pub enum Colors {
    Green,
    Red,
    Blue,
    Yellow,
}

pub enum TurnResults {
    Valid,
    Draw,
    BadArg,
    PlayerFinish,
    GameFinish,
}