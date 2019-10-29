/// A class representing a 7 card hand in a game of poker
public class BCHand7: BCPokerable {
    public let score: BCPokerScore
    public let category: BCPokerCategory
    
    /// Initalizes a new hand, calculating the highest possbile score and category for this set of cards. The score is calculated based on every size 5 combination of cards
    /// - Parameter cards: An array of cards
    /// - Remark: The array of cards must contain exactly 7 cards or this init will return nil
    public init?(cards: [BCCard]) {
        if (cards.count != 7) { return nil }
        var maxScore = BCPokerScoreMaker.none
        
        for subset in BCUtility.combinations7to5(from: cards) {
            let subsetScore = BCHandEvaluator.score(for: subset)
            maxScore = subsetScore > maxScore ? subsetScore : maxScore
        }
        
        self.score = maxScore
        self.category = BCPokerScoreMaker.category(of: score) ?? .highCard
    }
    
    /// Checks which hand has the higher score
    /// - Parameter otherHand: The opponent of the showdown
    /// - Returns: Win if this instance has a higher score, lose if this instance has a lower score, and draw if the they are both equal
    public func showdown(with otherHand: BCHand7) -> BCWinState {
        if (self > otherHand) { return .win }
        if (self < otherHand) { return .lose }
        return .draw
    }
    
    public static func < (lhs: BCHand7, rhs: BCHand7) -> Bool {
        return lhs.score < rhs.score
    }
    
    public static func <= (lhs: BCHand7, rhs: BCHand7) -> Bool {
        return lhs.score <= rhs.score
    }
    
    public static func >= (lhs: BCHand7, rhs: BCHand7) -> Bool {
        return lhs.score >= rhs.score
    }
    
    public static func > (lhs: BCHand7, rhs: BCHand7) -> Bool {
        return lhs.score > rhs.score
    }
    
    public static func == (lhs: BCHand7, rhs: BCHand7) -> Bool {
        return lhs.score == rhs.score
    }
}

