//
//  BCHand7.swift
//  BitCardPoker
//
//  Created by William Oropallo on 10/22/19.
//  Copyright © 2019 Oropallo Dev. All rights reserved.
//

class BCHand7: BCHand {
    let score: BCPokerScore
    
    init?(cards: [BCCard]) {
        if (cards.count != 7) { return nil }
        var maxScore = BCPokerScoreMaker.none
        
        for subset in BCUtility.combinations(from: cards, ofSize: 5) {
            let subsetScore = BCHandEvaluator.score(for: subset)
            maxScore = subsetScore > maxScore ? subsetScore : maxScore
        }
        
        self.score = maxScore
    }
}

