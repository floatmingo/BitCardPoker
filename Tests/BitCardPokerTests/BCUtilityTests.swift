//
//  BCUtilityTests.swift
//  BitCardPokerTests
//
//  Created by William Oropallo on 10/22/19.
//  Copyright © 2019 Oropallo Dev. All rights reserved.
//

import XCTest
@testable import BitCardPoker

class BCUtilityTests: XCTestCase {
    func testCombinations() {
        let testArray = [1, 2, 3, 4]
        
        XCTAssertEqual(BCUtility.combinations(from: testArray, ofSize: 0), [])
        XCTAssertEqual(BCUtility.combinations(from: testArray, ofSize: 1), [[1], [2], [3], [4]])
        XCTAssertEqual(BCUtility.combinations(from: testArray, ofSize: 2), [[1,2], [1,3], [1,4], [2,3], [2,4], [3,4]])
        XCTAssertEqual(BCUtility.combinations(from: testArray, ofSize: 3), [[1,2,3], [1,2,4], [1,3,4], [2,3,4]])
        XCTAssertEqual(BCUtility.combinations(from: testArray, ofSize: 4), [[1,2,3,4]])
        XCTAssertEqual(BCUtility.combinations(from: testArray, ofSize: 5), [])
    }
}
