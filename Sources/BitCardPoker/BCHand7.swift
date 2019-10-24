public class BCHand7: BCPokerable {
    public let score: BCPokerScore
    public let category: BCPokerCategory
    
    public init?(cards: [BCCard]) {
        if (cards.count != 7) { return nil }
        var maxScore = BCPokerScoreMaker.none
        
        for subset in BCUtility.combinations(from: cards, ofSize: 5) {
            let subsetScore = BCHandEvaluator.score(for: subset)
            maxScore = subsetScore > maxScore ? subsetScore : maxScore
        }
        
        self.score = maxScore
        self.category = BCPokerScoreMaker.category(of: score) ?? .highCard
    }
    
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

