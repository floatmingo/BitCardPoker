/// A card value type. Represents a standard french playing card.
public struct BCCard: Hashable {
    /// The rank of the card
    public let rank: BCRank
    
    /// The suit of the card
    public let suit: BCSuit
    
    
    /// Initalizes a new card with the given suit and rank. Suit and rank are fixed at the time of Initialization.
    /// - Parameter rank: The rank of the card.
    /// - Parameter suit: The suit of the card.
    public init(rank: BCRank, suit: BCSuit) {
        self.rank = rank
        self.suit = suit
    }
}
