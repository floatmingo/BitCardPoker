public typealias BCPokerScore = UInt32

struct BCPokerScoreMaker {
    static let none: BCPokerScore = 0
    
    public static func category(of score: BCPokerScore) -> BCPokerCategory? {
        return BCPokerCategory(rawValue: score >> (4 * 5))
    }
    
    static func makeFor(type: BCPokerCategory, _ rank1: BCRank) -> BCPokerScore {
        return type.rawValue << (4 * 5)
            + rank1.rawValue << (4 * 4)
    }

    static func makeFor(type: BCPokerCategory, _ rank1: BCRank, _ rank2: BCRank) -> BCPokerScore {
        return type.rawValue << (4 * 5)
            + rank1.rawValue << (4 * 4)
            + rank2.rawValue << (4 * 3)
    }
    
    static func makeFor(type: BCPokerCategory, _ rank1: BCRank, _ rank2: BCRank, _ rank3: BCRank) -> BCPokerScore {
        return type.rawValue << (4 * 5)
            + rank1.rawValue << (4 * 4)
            + rank2.rawValue << (4 * 3)
            + rank3.rawValue << (4 * 2)
    }
    
    static func makeFor(type: BCPokerCategory, _ rank1: BCRank, _ rank2: BCRank, _ rank3: BCRank, _ rank4: BCRank) -> BCPokerScore {
        return type.rawValue << (4 * 5)
            + rank1.rawValue << (4 * 4)
            + rank2.rawValue << (4 * 3)
            + rank3.rawValue << (4 * 2)
            + rank4.rawValue << (4 * 1)
    }
    
    static func makeFor(type: BCPokerCategory, _ rank1: BCRank, _ rank2: BCRank, _ rank3: BCRank, _ rank4: BCRank, _ rank5: BCRank) -> BCPokerScore {
        return type.rawValue << (4 * 5)
            + rank1.rawValue << (4 * 4)
            + rank2.rawValue << (4 * 3)
            + rank3.rawValue << (4 * 2)
            + rank4.rawValue << (4 * 1)
            + rank5.rawValue << (4 * 0)
    }
}

