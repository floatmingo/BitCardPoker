public class BCHand7: BCHand {
    public let score: BCPokerScore
    
    public init?(cards: [BCCard]) {
        if (cards.count != 7) { return nil }
        var maxScore = BCPokerScoreMaker.none
        
        for subset in BCUtility.combinations(from: cards, ofSize: 5) {
            let subsetScore = BCHandEvaluator.score(for: subset)
            maxScore = subsetScore > maxScore ? subsetScore : maxScore
        }
        
        self.score = maxScore
    }
    
    public func showdown(with otherHand: BCHand7) -> BCWinState {
        if (self > otherHand) { return .win }
        if (self < otherHand) { return .lose }
        return .draw
    }
}

