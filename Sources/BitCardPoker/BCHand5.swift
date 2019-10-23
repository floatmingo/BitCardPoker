public class BCHand5: BCHand {
    public let score: BCPokerScore
    
    public init?(cards: [BCCard]) {
        if (cards.count != 5) { return nil }
        self.score = BCHandEvaluator.score(for: cards)
    }
    
    public func showdown(with otherHand: BCHand5) -> BCWinState {
        if (self > otherHand) { return .win }
        if (self < otherHand) { return .lose }
        return .draw
    }
}
