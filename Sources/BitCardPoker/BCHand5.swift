//
//  BCHand5.swift
//  BitCardPoker
//
//  Created by William Oropallo on 10/19/19.
//  Copyright © 2019 Oropallo Dev. All rights reserved.
//

class BCHand5: BCHand {
    let score: BCPokerScore
    
    init?(cards: [BCCard]) {
        if (cards.count != 5) { return nil }
        self.score = BCHandEvaluator.score(for: cards)
    }
}
