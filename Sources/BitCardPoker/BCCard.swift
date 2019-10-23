public struct BCCard: Equatable {
    public let rank: BCRank
    public let suit: BCSuit
    
    public init(rank: BCRank, suit: BCSuit) {
        self.rank = rank
        self.suit = suit
    }
}
