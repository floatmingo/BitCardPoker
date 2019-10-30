class BCHandEvaluator {
    typealias Ranks = (BCRank, BCRank, BCRank, BCRank, BCRank)
    typealias Suits = (BCSuit, BCSuit, BCSuit, BCSuit, BCSuit)
    
    static func score(for cards: [BCCard]) -> BCPokerScore {
        if (cards.count != 5) { return BCPokerScoreMaker.none }
        
        var cardsClone = Array(cards)
        
        cardsClone.sort { $0.rank < $1.rank }
        let ranks = (
            cardsClone[0].rank,
            cardsClone[1].rank,
            cardsClone[2].rank,
            cardsClone[3].rank,
            cardsClone[4].rank
        )
        
        cardsClone.sort { $0.suit < $1.suit }
        let suits = (
            cardsClone[0].suit,
            cardsClone[1].suit,
            cardsClone[2].suit,
            cardsClone[3].suit,
            cardsClone[4].suit
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
        if isFlush(suits), let rank = isStraight(ranks) {
            return BCPokerScoreMaker.makeFor(type: .straightFlush, rank)
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
        if isFlush(suits) {
            return BCPokerScoreMaker.makeFor(type: .flush, ranks.4, ranks.3, ranks.2, ranks.1, ranks.0)
        }

        return BCPokerScoreMaker.none
    }
    
    static func calculateStraight(_ ranks: Ranks) -> BCPokerScore {
        if let rank = isStraight(ranks) {
            return BCPokerScoreMaker.makeFor(type: .straight, rank)
        }
        
        return BCPokerScoreMaker.none
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
    
    // Helpers
    private static func isStraight(_ ranks: Ranks) -> BCRank? {
        if ranks.0 == .two && ranks.1 == .three && ranks.2 == .four && ranks.3 == .five && ranks.4 == .ace {
            return .five
        }

        if ranks.1 == ranks.0.next() && ranks.2 == ranks.1.next() && ranks.3 == ranks.2.next() && ranks.4 == ranks.3.next() {
            return ranks.4
        }
        
        return nil
    }
    
    private static func isFlush(_ suits: Suits) -> Bool {
        return suits.0 == suits.4
    }
}
