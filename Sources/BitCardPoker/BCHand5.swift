public class BCHand5: BCPokerable {
    public let score: BCPokerScore
    public let category: BCPokerCategory
    
    public init?(cards: [BCCard]) {
        if (cards.count != 5) { return nil }
        self.score = BCHandEvaluator.score(for: cards)
        self.category = BCPokerScoreMaker.category(of: score) ?? .highCard
    }
    
    public func showdown(with otherHand: BCHand5) -> BCWinState {
        if (self > otherHand) { return .win }
        if (self < otherHand) { return .lose }
        return .draw
    }
    
    public static func < (lhs: BCHand5, rhs: BCHand5) -> Bool {
        return lhs.score < rhs.score
    }
    
    public static func <= (lhs: BCHand5, rhs: BCHand5) -> Bool {
        return lhs.score <= rhs.score
    }
    
    public static func >= (lhs: BCHand5, rhs: BCHand5) -> Bool {
        return lhs.score >= rhs.score
    }
    
    public static func > (lhs: BCHand5, rhs: BCHand5) -> Bool {
        return lhs.score > rhs.score
    }
    
    public static func == (lhs: BCHand5, rhs: BCHand5) -> Bool {
        return lhs.score == rhs.score
    }
}
