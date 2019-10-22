class BCHandEvaluator {
    typealias Ranks = (BCRank, BCRank, BCRank, BCRank, BCRank)
    typealias Suits = (BCSuit, BCSuit, BCSuit, BCSuit, BCSuit)
    
    static func score(for cards: [BCCard]) -> BCPokerScore {
        if (cards.count != 5) { return BCPokerScoreMaker.none }
        
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
        
        let straightFlush = calculateStraightFlush(ranks, suits)
        if straightFlush != BCPokerScoreMaker.none { return straightFlush }
        
        let fourOfAKind = calculateFourOfAKind(ranks)
        if fourOfAKind != BCPokerScoreMaker.none { return fourOfAKind }
        
        let fullHouse = calculateFullHouse(ranks)
        if fullHouse != BCPokerScoreMaker.none { return fullHouse }
        
        let flush = calculateFlush(ranks, suits)
        if flush != BCPokerScoreMaker.none { return flush }
        
        let straight = calculateStraight(ranks)
        if straight != BCPokerScoreMaker.none { return straight }
        
        let threeOfAKind = calculateThreeOfAKind(ranks)
        if threeOfAKind != BCPokerScoreMaker.none { return threeOfAKind }
        
        let twoPair = calculateTwoPair(ranks)
        if twoPair != BCPokerScoreMaker.none { return twoPair }
        
        let onePair = calculateOnePair(ranks)
        if onePair != BCPokerScoreMaker.none { return onePair }
        
        return calculateHighCard(ranks)
    }

    // Utilities
    static func calculateStraightFlush(_ ranks: Ranks, _ suits: Suits) -> BCPokerScore {
        if (calculateFlush(ranks, suits) != BCPokerScoreMaker.none && calculateStraight(ranks) != BCPokerScoreMaker.none) {
            return BCPokerScoreMaker.makeFor(type: .straightFlush, ranks.4)
        }
        
        return BCPokerScoreMaker.none
    }

    static func calculateFourOfAKind(_ ranks: Ranks) -> BCPokerScore {
        let middleMatch = ranks.1 == ranks.2 && ranks.2 == ranks.3

        /*
        Case: Quad is lower than the Kicker
        Cards:      0  1  2  3  4
        Positions:  Q  Q  Q  Q  K1
        */
        if ranks.0 == ranks.1 && middleMatch {
            return BCPokerScoreMaker.makeFor(type: .fourOfAKind, ranks.0, ranks.4)
        }
        
        /*
        Case: Quad is higher than the Kicker
        Cards:      0  1  2  3  4
        Positions:  K1 Q  Q  Q  Q
        */
        if middleMatch && ranks.3 == ranks.4 {
            return BCPokerScoreMaker.makeFor(type: .fourOfAKind, ranks.4, ranks.0)
        }
        
        return BCPokerScoreMaker.none
    }

    static func calculateFullHouse(_ ranks: Ranks) -> BCPokerScore {
        let edgeMatches = ranks.0 == ranks.1 && ranks.3 == ranks.4
        
        /*
        Case: Triple is lower than the Pair
        Cards:      0  1  2  3  4
        Positions:  T  T  T  P  P
        */
        if ranks.1 == ranks.2 && edgeMatches {
            return BCPokerScoreMaker.makeFor(type: .fullHouse, ranks.0, ranks.3)
        }
        
        /*
        Case: Triple is higher than the Pair
        Cards:      0  1  2  3  4
        Positions:  P  P  T  T  T
        */
        if ranks.2 == ranks.3 && edgeMatches {
            return BCPokerScoreMaker.makeFor(type: .fullHouse, ranks.2, ranks.0)
        }
        
        return BCPokerScoreMaker.none
    }

    static func calculateFlush(_ ranks: Ranks, _ suits: Suits) -> BCPokerScore {
        if suits.0 == suits.4 {
            return BCPokerScoreMaker.makeFor(type: .flush, ranks.4, ranks.3, ranks.2, ranks.1, ranks.0)
        }

        return BCPokerScoreMaker.none
    }

    static func calculateStraight(_ ranks: Ranks) -> BCPokerScore {
        if (ranks.4 == .ace) {
            if ranks.0 == .two && ranks.1 == .three && ranks.2 == .four && ranks.3 == .five {
                return BCPokerScoreMaker.makeFor(type: .straight, BCRank.five)
            }
            
            if ranks.0 == .ten && ranks.1 == .jack && ranks.2 == .queen && ranks.3 == .king {
                return BCPokerScoreMaker.makeFor(type: .straight, BCRank.ace)
            }
            
            return BCPokerScoreMaker.none
        }
        
        if ranks.1 != ranks.0.next() { return BCPokerScoreMaker.none }
        if ranks.2 != ranks.1.next() { return BCPokerScoreMaker.none }
        if ranks.3 != ranks.2.next() { return BCPokerScoreMaker.none }
        if ranks.4 != ranks.3.next() { return BCPokerScoreMaker.none }
        
        return BCPokerScoreMaker.makeFor(type: .straight, ranks.4)
    }

    static func calculateThreeOfAKind(_ ranks: Ranks) -> BCPokerScore {
        let lowMidPair = ranks.1 == ranks.2
        let highMidPair = ranks.2 == ranks.3
        
        /*
        Case: Triple is lower than the two kickers
        Cards:      0  1  2  3  4
        Positions:  T  T  T  K2 K1
        */
        if ranks.0 == ranks.1 && lowMidPair {
            return BCPokerScoreMaker.makeFor(type: .threeOfAKind, ranks.2, ranks.4, ranks.3)
        }
        
        /*
        Case: Triple is between the two kickers
        Cards:      0  1  2  3  4
        Positions:  K2 T  T  T  K1
        */
        if lowMidPair && highMidPair {
            return BCPokerScoreMaker.makeFor(type: .threeOfAKind, ranks.2, ranks.4, ranks.0)
        }
        
        /*
        Case: Triple is higher than the two kickers
        Cards:      0  1  2  3  4
        Positions:  K2 K1 T  T  T
        */
        if highMidPair && ranks.3 == ranks.4 {
            return BCPokerScoreMaker.makeFor(type: .threeOfAKind, ranks.2, ranks.1, ranks.0)
        }
        
        return BCPokerScoreMaker.none
    }

    static func calculateTwoPair(_ ranks: Ranks) -> BCPokerScore {
        let lowPair = ranks.0 == ranks.1
        let highPair = ranks.3 == ranks.4

        /*
        Case: Both Pairs are lower than the kicker
        Cards:      0  1  2  3  4
        Positions:  P2 P2 P1 P1 K1
        */
        if lowPair && ranks.2 == ranks.3 {
            return BCPokerScoreMaker.makeFor(type: .twoPair, ranks.2, ranks.0, ranks.4)
        }

        /*
        Case: The Pairs are split by the kicker
        Cards:      0  1  2  3  4
        Positions:  P2 P2 K1 P1 P1
        */
        if lowPair && highPair {
            return BCPokerScoreMaker.makeFor(type: .twoPair, ranks.3, ranks.0, ranks.2)
        }

        /*
        Case: Both Pairs are higher than the kicker
        Cards:      0  1  2  3  4
        Positions:  K1 P2 P2 P1 P1
        */
        if ranks.1 == ranks.2 && highPair {
            return BCPokerScoreMaker.makeFor(type: .twoPair, ranks.3, ranks.1, ranks.0)
        }

        return BCPokerScoreMaker.none
    }
    
    static func calculateOnePair(_ ranks: Ranks) -> BCPokerScore {
        /*
        Case: Pair is lower than the kickers
        Cards:      0  1  2  3  4
        Positions:  P  P  K3 K2 K1
        */
        if ranks.0 == ranks.1 {
            return BCPokerScoreMaker.makeFor(type: .onePair, ranks.0, ranks.4, ranks.3, ranks.2)
        }

        /*
        Case: Pair is lower than the 2 kickers but lower than 1 kicker
        Cards:      0  1  2  3  4
        Positions:  K3 P  P  K2 K1
        */
        if ranks.1 == ranks.2 {
            return BCPokerScoreMaker.makeFor(type: .onePair, ranks.1, ranks.4, ranks.3, ranks.0)
        }
        
        /*
        Case: Pair is higher than the 2 kickers but lower than 1 kicker
        Cards:      0  1  2  3  4
        Positions:  K3 K2 P  P  K1
        */
        if ranks.2 == ranks.3 {
            return BCPokerScoreMaker.makeFor(type: .onePair, ranks.2, ranks.4, ranks.1, ranks.0)
        }
        
        /*
        Case: Pair is higher than the 2 kickers but lower than 1 kicker
        Cards:      0  1  2  3  4
        Positions:  K3 K2 K1 P  P
        */
        if ranks.3 == ranks.4 {
            return BCPokerScoreMaker.makeFor(type: .onePair, ranks.3, ranks.2, ranks.1, ranks.0)
        }
        
        return BCPokerScoreMaker.none
    }
    
    static func calculateHighCard(_ ranks: Ranks) -> BCPokerScore {
        return BCPokerScoreMaker.makeFor(type: .highCard, ranks.4, ranks.3, ranks.2, ranks.1, ranks.0)
    }
}
