/// A class representing a 5 card hand in a game of poker
public class BCHand5: BCPokerable {
    public let score: BCPokerScore
    public let category: BCPokerCategory
    
    /// Initalizes a new hand, calculating the highest possbile score and category for this set of cards
    /// - Parameter cards: An array of cards
    /// - Remark: The array of cards must contain exactly 5 cards, or this init will return nil
    public init?(cards: [BCCard]) {
        if (cards.count != 5) { return nil }
        self.score = BCHandEvaluator.score(for: cards)
        self.category = BCPokerScoreMaker.category(of: score) ?? .highCard
    }
    
    /// Checks which hand has the higher score
    /// - Parameter otherHand: The opponent of the showdown
    /// - Returns: Win if this instance has a higher score, lose if this instance has a lower score, and draw if the they are both equal
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
