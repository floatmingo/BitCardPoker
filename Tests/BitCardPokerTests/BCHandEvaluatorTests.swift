//
//  BCHandEvaluatorTests.swift
//  BitCardPokerTests
//
//  Created by William Oropallo on 10/20/19.
//  Copyright © 2019 Oropallo Dev. All rights reserved.
//

import XCTest
@testable import BitCardPoker

class BCHandEvaluatorTests: XCTestCase {
    typealias Ranks = (BCRank, BCRank, BCRank, BCRank, BCRank)
    typealias Suits = (BCSuit, BCSuit, BCSuit, BCSuit, BCSuit)

    func mockUp(from str: String) -> (ranks: Ranks, suits: Suits)? {
        guard let cards = BCUtility.makeCardArray(from: str) else {
            return nil
        }
        
        if (cards.count != 5) { return nil }
        
        let cardsByRank = cards.sorted { $0.rank < $1.rank }
        let ranks = (
            cardsByRank[0].rank,
            cardsByRank[1].rank,
            cardsByRank[2].rank,
            cardsByRank[3].rank,
            cardsByRank[4].rank
        )
        
        let cardsBySuit = cards.sorted { $0.suit < $1.suit }
        let suits = (
            cardsBySuit[0].suit,
            cardsBySuit[1].suit,
            cardsBySuit[2].suit,
            cardsBySuit[3].suit,
            cardsBySuit[4].suit
        )
        
        return (ranks, suits)
    }
    
    func testEvaluate() {
        let SF = BCUtility.makeCardArray(from: "8C 7C 6C 5C 4C")!
        XCTAssertEqual(BCHandEvaluator.score(for: SF), BCPokerScoreMaker.makeFor(type: .straightFlush, .eight))

        let FK = BCUtility.makeCardArray(from: "6H 6C 6S 6D TS")!
        XCTAssertEqual(BCHandEvaluator.score(for: FK), BCPokerScoreMaker.makeFor(type: .fourOfAKind, .six, .ten))

        let FH = BCUtility.makeCardArray(from: "5H 5D 5S KD KH")!
        XCTAssertEqual(BCHandEvaluator.score(for: FH), BCPokerScoreMaker.makeFor(type: .fullHouse, .five, .king))

        let FL = BCUtility.makeCardArray(from: "JH 2H TH 3H 8H")!
        XCTAssertEqual(BCHandEvaluator.score(for: FL), BCPokerScoreMaker.makeFor(type: .flush, .jack, .ten, .eight, .three, .two))
        
        let ST = BCUtility.makeCardArray(from: "2D 4C AH 5C 3H")!
        XCTAssertEqual(BCHandEvaluator.score(for: ST), BCPokerScoreMaker.makeFor(type: .straight, .five))

        let TK = BCUtility.makeCardArray(from: "TH TD TC JS 9S")!
        XCTAssertEqual(BCHandEvaluator.score(for: TK), BCPokerScoreMaker.makeFor(type: .threeOfAKind, .ten, .jack, .nine))

        let TP = BCUtility.makeCardArray(from: "TH 4S 4H TD 9S")!
        XCTAssertEqual(BCHandEvaluator.score(for: TP), BCPokerScoreMaker.makeFor(type: .twoPair, .ten, .four, .nine))
        
        let OP = BCUtility.makeCardArray(from: "QD TS 5H 4C QS")!
        XCTAssertEqual(BCHandEvaluator.score(for: OP), BCPokerScoreMaker.makeFor(type: .onePair, .queen, .ten, .five, .four))
        
        let HC = BCUtility.makeCardArray(from: "5H 6D 7S QH 2H")!
        XCTAssertEqual(BCHandEvaluator.score(for: HC), BCPokerScoreMaker.makeFor(type: .highCard, .queen, .seven, .six, .five, .two))
    }
    
    func testStraightFlush() {
        let noStraightFlush = mockUp(from: "2H 3D TH 4C 6S")!
        XCTAssertEqual(BCHandEvaluator.calculateStraightFlush(noStraightFlush.ranks, noStraightFlush.suits), BCPokerScoreMaker.none)
        
        let straightNoFlush = mockUp(from: "2H 3D 5S 4C 6S")!
        XCTAssertEqual(BCHandEvaluator.calculateStraightFlush(straightNoFlush.ranks, straightNoFlush.suits), BCPokerScoreMaker.none)
        
        let flushNoStraight = mockUp(from: "6H TH JH 2H AH")!
        XCTAssertEqual(BCHandEvaluator.calculateStraightFlush(flushNoStraight.ranks, flushNoStraight.suits), BCPokerScoreMaker.none)
        
        let royalFlush = mockUp(from: "KD JD AD TD QD")!
        XCTAssertEqual(BCHandEvaluator.calculateStraightFlush(royalFlush.ranks, royalFlush.suits), BCPokerScoreMaker.makeFor(type: .straightFlush, .ace))
        
        let regularStraightFlush = mockUp(from: "8C 7C 6C 5C 4C")!
        XCTAssertEqual(BCHandEvaluator.calculateStraightFlush(regularStraightFlush.ranks, regularStraightFlush.suits), BCPokerScoreMaker.makeFor(type: .straightFlush, .eight))
    }

    func testFourOfAKind() {
        let noFOAK = mockUp(from: "5H 3C 5S 5D 2H")!.ranks
        XCTAssertEqual(BCHandEvaluator.calculateFourOfAKind(noFOAK), BCPokerScoreMaker.none)
        
        let lowFOAK = mockUp(from: "6H 6C 6S 6D TS")!.ranks
        XCTAssertEqual(BCHandEvaluator.calculateFourOfAKind(lowFOAK), BCPokerScoreMaker.makeFor(type: .fourOfAKind, .six, .ten))
        
        let highFOAK = mockUp(from: "5H 5C 5S 5D 2H")!.ranks
        XCTAssertEqual(BCHandEvaluator.calculateFourOfAKind(highFOAK), BCPokerScoreMaker.makeFor(type: .fourOfAKind, .five, .two))
    }

    func testFullHouse() {
        let noFH = mockUp(from: "5H AD 5S 5D 2H")!.ranks
        XCTAssertEqual(BCHandEvaluator.calculateFullHouse(noFH), BCPokerScoreMaker.none)
        
        let lowPair = mockUp(from: "7H 7C 7S 3H 3S")!.ranks
        XCTAssertEqual(BCHandEvaluator.calculateFullHouse(lowPair), BCPokerScoreMaker.makeFor(type: .fullHouse, .seven, .three))
        
        let lowTrip = mockUp(from: "5H 5D 5S KD KH")!.ranks
        XCTAssertEqual(BCHandEvaluator.calculateFullHouse(lowTrip), BCPokerScoreMaker.makeFor(type: .fullHouse, .five, .king))
    }
    
    func testFlush() {
        let noFlush = mockUp(from: "5H AD 5S 5D 2H")!
        XCTAssertEqual(BCHandEvaluator.calculateFlush(noFlush.ranks, noFlush.suits), BCPokerScoreMaker.none)
        
        let flushH = mockUp(from: "JH 2H TH 3H 8H")!
        XCTAssertEqual(BCHandEvaluator.calculateFlush(flushH.ranks, flushH.suits)
           , BCPokerScoreMaker.makeFor(type: .flush, .jack, .ten, .eight, .three, .two)
        )
        
        let flushD = mockUp(from: "AD 2D 7D 3D 8D")!
        XCTAssertEqual(BCHandEvaluator.calculateFlush(flushD.ranks, flushD.suits)
           , BCPokerScoreMaker.makeFor(type: .flush, .ace, .eight, .seven, .three, .two)
        )
    }
    
    func testStraight() {
        let noStraight = mockUp(from: "5H AD 5S 5D 2H")!.ranks
        XCTAssertEqual(BCHandEvaluator.calculateStraight(noStraight), BCPokerScoreMaker.none)
        
        let lowStraight = mockUp(from: "2D 4C AH 5C 3H")!.ranks
        XCTAssertEqual(BCHandEvaluator.calculateStraight(lowStraight), BCPokerScoreMaker.makeFor(type: .straight, .five))
        
        let highStraight = mockUp(from: "AD QD JC KH TC")!.ranks
        XCTAssertEqual(BCHandEvaluator.calculateStraight(highStraight), BCPokerScoreMaker.makeFor(type: .straight, .ace))
        
        let regularStraight = mockUp(from: "JS 9D QH 8C TS")!.ranks
        XCTAssertEqual(BCHandEvaluator.calculateStraight(regularStraight), BCPokerScoreMaker.makeFor(type: .straight, .queen))
    }
    
    func testThreeOfAKind() {
        let noTOAK = mockUp(from: "5H AD TS 2D 2H")!.ranks
        XCTAssertEqual(BCHandEvaluator.calculateThreeOfAKind(noTOAK), BCPokerScoreMaker.none)
        
        let lowerTOAK = mockUp(from: "5D TC 5H KC 5C")!.ranks
        XCTAssertEqual(BCHandEvaluator.calculateThreeOfAKind(lowerTOAK), BCPokerScoreMaker.makeFor(type: .threeOfAKind, .five, .king, .ten))
        
        let splitTOAK = mockUp(from: "TH TD TC JS 9S")!.ranks
        XCTAssertEqual(BCHandEvaluator.calculateThreeOfAKind(splitTOAK), BCPokerScoreMaker.makeFor(type: .threeOfAKind, .ten, .jack, .nine))
        
        let higherTOAK = mockUp(from: "KS 9D 9H KC KD")!.ranks
        XCTAssertEqual(BCHandEvaluator.calculateThreeOfAKind(higherTOAK), BCPokerScoreMaker.makeFor(type: .threeOfAKind, .king, .nine, .nine))
    }
    
    func testTwoPair() {
        let noTP = mockUp(from: "5H 6D TS TH 2H")!.ranks
        XCTAssertEqual(BCHandEvaluator.calculateTwoPair(noTP), BCPokerScoreMaker.none)
        
        let lowerTP = mockUp(from: "2D 2S 3C KC 3H")!.ranks
        XCTAssertEqual(BCHandEvaluator.calculateTwoPair(lowerTP), BCPokerScoreMaker.makeFor(type: .twoPair, .three, .two, .king))
        
        let splitTP = mockUp(from: "TH 4S 4H TD 9S")!.ranks
        XCTAssertEqual(BCHandEvaluator.calculateTwoPair(splitTP), BCPokerScoreMaker.makeFor(type: .twoPair, .ten, .four, .nine))
        
        let higherTP = mockUp(from: "KS TS TD 4C KD")!.ranks
        XCTAssertEqual(BCHandEvaluator.calculateTwoPair(higherTP), BCPokerScoreMaker.makeFor(type: .twoPair, .king, .ten, .four))
    }
    
    func testOnePair() {
        let noOP = mockUp(from: "5H 6D 7S TH 2H")!.ranks
        XCTAssertEqual(BCHandEvaluator.calculateOnePair(noOP), 0)
        
        let lowerOP = mockUp(from: "2D 2S 3C KC 4D")!.ranks
        XCTAssertEqual(BCHandEvaluator.calculateOnePair(lowerOP), BCPokerScoreMaker.makeFor(type: .onePair, .two, .king, .four, .three))
        
        let split1OP = mockUp(from: "2D 4S 4H TD 9S")!.ranks
        XCTAssertEqual(BCHandEvaluator.calculateOnePair(split1OP), BCPokerScoreMaker.makeFor(type: .onePair, .four, .ten, .nine, .two))
        
        let split2OP = mockUp(from: "3D 2D TH TD KH")!.ranks
        XCTAssertEqual(BCHandEvaluator.calculateOnePair(split2OP), BCPokerScoreMaker.makeFor(type: .onePair, .ten, .king, .three, .two))
        
        let higherOP = mockUp(from: "QD TS 5H 4C QS")!.ranks
        XCTAssertEqual(BCHandEvaluator.calculateOnePair(higherOP), BCPokerScoreMaker.makeFor(type: .onePair, .queen, .ten, .five, .four))
    }
    
    func testHighCard() {
        let highCard = mockUp(from: "5H 6D 7S TH 2H")!.ranks
        XCTAssertEqual(BCHandEvaluator.calculateHighCard(highCard), BCPokerScoreMaker.makeFor(type: .highCard, .ten, .seven, .six, .five, .two))
    }
}
