//
//  BCPokerScoreCalcTests.swift
//  BitCardPokerTests
//
//  Created by William Oropallo on 10/22/19.
//  Copyright © 2019 Oropallo Dev. All rights reserved.
//

import XCTest
@testable import BitCardPoker

class BCPokerScoreCalcTests: XCTestCase {
    func testMakeFor1() {
        let value: BCPokerScore = 0b0101_0010_0000_0000_0000_0000
        XCTAssertEqual(BCPokerScoreMaker.makeFor(type: .straight, .two), value)
    }
    
    func testMakeFor2() {
        let value: BCPokerScore = 0b0111_0100_0011_0000_0000_0000
        XCTAssertEqual(BCPokerScoreMaker.makeFor(type: .fullHouse, .four, .three), value)
    }
    
    func testMakeFor3() {
        let value: BCPokerScore = 0b0011_1110_1100_1001_0000_0000
        XCTAssertEqual(BCPokerScoreMaker.makeFor(type: .twoPair, .ace, .queen, .nine), value)
    }
    
    func testMakeFor4() {
        let value: BCPokerScore = 0b0010_0110_0101_0100_0011_0000
        XCTAssertEqual(BCPokerScoreMaker.makeFor(type: .onePair, .six, .five, .four, .three), value)
    }
    
    func testMakeFor5() {
        let value: BCPokerScore = 0b0001_1110_1100_1010_1000_0110
        XCTAssertEqual(BCPokerScoreMaker.makeFor(type: .highCard, .ace, .queen, .ten, .eight, .six), value)
    }
    
    func testCategory() {
        let value1: BCPokerScore = 0b0001_1110_1100_1010_1000_0110
        XCTAssertEqual(BCPokerScoreMaker.category(of: value1), BCPokerCategory.highCard)
        
        let value2: BCPokerScore = 0b1111_1110_1100_1010_1000_0110
        XCTAssertEqual(BCPokerScoreMaker.category(of: value2), nil)
    }
}
