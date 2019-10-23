class BCDeck {
    private static let base52 = BCSuit.allCases.flatMap { (suit: BCSuit) -> [BCCard] in
        BCRank.allCases.map { (rank: BCRank) -> BCCard in
            return BCCard(rank: rank, suit: suit)
        }
    }
    
    private var cards: [BCCard]
    
    var count: Int {
        get {
            return cards.count
        }
    }
    
    var isEmpty: Bool {
        get {
            return cards.isEmpty
        }
    }
    
    init() {
        cards = Array(BCDeck.base52)
    }
    
    convenience init(without removalCards: [BCCard]) {
        self.init()
        cards.removeAll { removalCards.contains($0) }
    }
    
    func deal() -> BCCard? {
        if cards.isEmpty {
            return nil
        }

        return cards.removeLast()
    }
    
    func shuffle() {
        cards.shuffle()
    }
}

