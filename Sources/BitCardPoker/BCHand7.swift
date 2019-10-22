class BCHand7: BCHand {
    let score: BCPokerScore
    
    init?(cards: [BCCard]) {
        if (cards.count != 7) { return nil }
        var maxScore = BCPokerScoreMaker.none
        
        for subset in BCUtility.combinations(from: cards, ofSize: 5) {
            let subsetScore = BCHandEvaluator.score(for: subset)
            maxScore = subsetScore > maxScore ? subsetScore : maxScore
        }
        
        self.score = maxScore
    }
}

