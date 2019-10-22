class BCHand5: BCHand {
    let score: BCPokerScore
    
    init?(cards: [BCCard]) {
        if (cards.count != 5) { return nil }
        self.score = BCHandEvaluator.score(for: cards)
    }
}
