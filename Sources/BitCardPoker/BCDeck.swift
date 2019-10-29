/// A type to represent a standard 52 card french playing card Deck. 
public class BCDeck {
    private static let base52 = BCSuit.allCases.flatMap { (suit: BCSuit) -> [BCCard] in
        BCRank.allCases.map { (rank: BCRank) -> BCCard in
            return BCCard(rank: rank, suit: suit)
        }
    }
    
    /// Storage for the cards in the deck.
    private var cards: [BCCard]
    
    /// The number of cards currently in the deck.
    public var count: Int {
        get {
            return cards.count
        }
    }
    
    /// A Boolean value indicating whether the deck is empty.
    public var isEmpty: Bool {
        get {
            return cards.isEmpty
        }
    }
    
    /// Initalizes a new deck with the standard 52 cards, grouped by suit and ordered starting with highest rank
    public init() {
        cards = Array(BCDeck.base52)
    }
    
    /// Initalizes a new deck with the standard 52 cards, grouped by suit and ordered starting with highest rank, without the given cards
    /// - Parameter removalCards: An array of cards to be excluded from the deck.
    public convenience init(without removalCards: [BCCard]) {
        self.init()
        cards.removeAll { removalCards.contains($0) }
    }
    
    /// Deal a single card from the deck, if possible. The card is removed from the deck permanently
    /// - Returns: The next card in the deck. If the deck is empty, returns nil.
    public func deal() -> BCCard? {
        if cards.isEmpty {
            return nil
        }

        return cards.removeLast()
    }
    
    /// Shuffles the current cards in the deck inplace.
    public func shuffle() {
        cards.shuffle()
    }
}

