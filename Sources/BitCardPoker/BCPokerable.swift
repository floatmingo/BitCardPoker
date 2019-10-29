/// A type that can represent a party in a poker game using a score and a poker category.
protocol BCPokerable: Comparable {
    /// A score value that represents a quantitative indicator of a hand
    var score: BCPokerScore { get }
    /// A category value indicating the highest poker hand of this card combination
    var category: BCPokerCategory { get }
}
