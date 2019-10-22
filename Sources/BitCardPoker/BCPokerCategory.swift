//
//  BCPokerCategory.swift
//  BitCardPoker
//
//  Created by William Oropallo on 10/22/19.
//  Copyright © 2019 Oropallo Dev. All rights reserved.
//

enum BCPokerCategory: UInt32 {
    case highCard = 1
    case onePair
    case twoPair
    case threeOfAKind
    case straight
    case flush
    case fullHouse
    case fourOfAKind
    case straightFlush = 9
}
