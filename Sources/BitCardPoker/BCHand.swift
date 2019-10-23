enum BCWinState {
    case win
    case draw
    case lose
}

protocol BCHand: class, Comparable {
    var score: BCPokerScore { get }
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
    
    public func showdownResults<T: BCHand>(with otherHand: T) -> BCWinState {
        if (self.score > otherHand.score) {
            return .win
        }
        
        if (self.score < otherHand.score) {
            return .lose
        }
        
        return .draw
    }
}
