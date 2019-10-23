import XCTest
@testable import BitCardPoker

class BCDeckTests: XCTestCase {
    func testDeal() {
        let deck = BCDeck()
        
        XCTAssertEqual(deck.deal()!, BCCard(rank: .ace, suit: .spades))
        XCTAssertEqual(deck.deal()!, BCCard(rank: .king, suit: .spades))
    }
    
    func testEmptyDeal() {
        let deck = BCDeck()
        
        let count = deck.count
        for _ in 0...count {
            let _ = deck.deal()
        }
        
        XCTAssertNil(deck.deal())
    }
    
    func testDealWithRemoval() {
        let deck = BCDeck(without: [
            BCCard(rank: .ace, suit: .spades),
            BCCard(rank: .king, suit: .spades),
            BCCard(rank: .jack, suit: .spades)
        ])
        
        XCTAssertEqual(deck.deal()!, BCCard(rank: .queen, suit: .spades))
        XCTAssertEqual(deck.deal()!, BCCard(rank: .ten, suit: .spades))
    }
}
