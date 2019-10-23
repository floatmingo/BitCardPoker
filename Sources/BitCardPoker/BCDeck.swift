public class BCDeck {
    private static let base52 = BCSuit.allCases.flatMap { (suit: BCSuit) -> [BCCard] in
        BCRank.allCases.map { (rank: BCRank) -> BCCard in
            return BCCard(rank: rank, suit: suit)
        }
    }
    
    private var cards: [BCCard]
    
    public var count: Int {
        get {
            return cards.count
        }
    }
    
    public var isEmpty: Bool {
        get {
            return cards.isEmpty
        }
    }
    
    public init() {
        cards = Array(BCDeck.base52)
    }
    
    public convenience init(without removalCards: [BCCard]) {
        self.init()
        cards.removeAll { removalCards.contains($0) }
    }
    
    public func deal() -> BCCard? {
        if cards.isEmpty {
            return nil
        }

        return cards.removeLast()
    }
    
    public func shuffle() {
        cards.shuffle()
    }
}

