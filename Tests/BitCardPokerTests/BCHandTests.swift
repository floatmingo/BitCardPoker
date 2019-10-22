import XCTest
@testable import BitCardPoker

class BCHandTests: XCTestCase {
    func testHand5() {
        let royalFlushCards = BCUtility.makeCardArray(from: "AH TH JH KH QH")!
        let foakCards = BCUtility.makeCardArray(from: "TD TH TC TS QH")!
        let flush1Cards = BCUtility.makeCardArray(from: "2H 3H 4H 5H 7H")!
        let flush2Cards = BCUtility.makeCardArray(from: "TD AD 2D 4D QD")!
        let highCardCards = BCUtility.makeCardArray(from: "AH 3S 5C KD TC")!
        
        let royalFlush = BCHand5(cards: royalFlushCards)!
        let foak = BCHand5(cards: foakCards)!
        let flush1 = BCHand5(cards: flush1Cards)!
        let flush2 = BCHand5(cards: flush2Cards)!
        let highCard = BCHand5(cards: highCardCards)!
        
        XCTAssertTrue(royalFlush > flush1)
        XCTAssertTrue(flush1 < flush2)
        XCTAssertTrue(royalFlush == royalFlush)
        XCTAssertTrue(foak >= highCard)
        XCTAssertTrue(highCard <= flush1)
        XCTAssertTrue(highCard <= highCard)
    }
    
    func testHand7() {
        let board = "4C KS 4H 8S 7S "
        
        let bobCards = BCUtility.makeCardArray(from: board + "AC 4D")!
        let carolCards = BCUtility.makeCardArray(from: board + "AS 9S")!
        let tedCards = BCUtility.makeCardArray(from: board + "KH KD")!
        let aliceCards = BCUtility.makeCardArray(from: board + "5D 6D")!
        let kerryCards = BCUtility.makeCardArray(from: board + "AD 2C")!
        let chadCards = BCUtility.makeCardArray(from: board + "AC 2S")!
        
        let bob = BCHand7(cards: bobCards)!
        let carol = BCHand7(cards: carolCards)!
        let ted = BCHand7(cards: tedCards)!
        let alice = BCHand7(cards: aliceCards)!
        let kerry = BCHand7(cards: kerryCards)!
        let chad = BCHand7(cards: chadCards)!
        
        XCTAssertEqual(bob.score, BCPokerScoreMaker.makeFor(type: .threeOfAKind, .four, .ace, .king))
        XCTAssertEqual(carol.score, BCPokerScoreMaker.makeFor(type: .flush, .ace, .king, .nine, .eight, .seven))
        XCTAssertEqual(ted.score, BCPokerScoreMaker.makeFor(type: .fullHouse, .king, .four))
        XCTAssertEqual(alice.score, BCPokerScoreMaker.makeFor(type: .straight, .eight))
        XCTAssertEqual(kerry.score, BCPokerScoreMaker.makeFor(type: .onePair, .four, .ace, .king, .eight))
        
        XCTAssertTrue(ted > carol)
        XCTAssertTrue(alice < carol)
        XCTAssertTrue(alice >= bob)
        XCTAssertTrue(kerry <= bob)
        XCTAssertTrue(kerry == chad)
    }
    
    func testShowdown() {
        let board = "4C KS 4H 8S 7S "
        
        let tedCards = BCUtility.makeCardArray(from: board + "KH KD")!
        let kerryCards = BCUtility.makeCardArray(from: board + "AD 2C")!
        let royalFlushCards = BCUtility.makeCardArray(from: "AH TH JH KH QH")!
        
        let ted = BCHand7(cards: tedCards)!
        let kerry = BCHand7(cards: kerryCards)!
        let royalFlush = BCHand5(cards: royalFlushCards)!
        
        XCTAssertEqual(ted.showdownResults(with: kerry), .win)
        XCTAssertEqual(kerry.showdownResults(with: ted), .lose)
        XCTAssertEqual(royalFlush.showdownResults(with: ted), .win)
        XCTAssertEqual(royalFlush.showdownResults(with: royalFlush), .draw)
    }
}
