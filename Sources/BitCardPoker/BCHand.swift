protocol BCHand: class, Comparable {
    var score: BCPokerScore { get }
    var category: BCPokerCategory { get }
}

extension BCHand {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.score < rhs.score
    }
    
    public static func <= (lhs: Self, rhs: Self) -> Bool {
        return lhs.score <= rhs.score
    }
    
    public static func >= (lhs: Self, rhs: Self) -> Bool {
        return lhs.score >= rhs.score
    }
    
    public static func > (lhs: Self, rhs: Self) -> Bool {
        return lhs.score > rhs.score
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.score == rhs.score
    }
}
