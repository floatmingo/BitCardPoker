/// An enum representing the nine categories of poker hand when using a standard 52-card deck
public enum BCPokerCategory: UInt32, CaseIterable {
    case highCard = 1
    case onePair
    case twoPair
    case threeOfAKind
    case straight
    case flush
    case fullHouse
    case fourOfAKind
    case straightFlush = 9
}

extension BCPokerCategory: CustomStringConvertible {
    public var description: String {
        get {
            switch self {
            case .highCard:      return "High Card"
            case .onePair:       return "One Pair"
            case .twoPair:       return "Two Pair"
            case .threeOfAKind:  return "Three of a Kind"
            case .straight:      return "Straight"
            case .flush:         return "Flush"
            case .fullHouse:     return "Full House"
            case .fourOfAKind:   return "Four of a Kind"
            case .straightFlush: return "Straight Flush"
            }
        }
    }
}
