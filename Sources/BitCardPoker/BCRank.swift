/// An enum that represents the thirteen ranks of French playing cards.
public enum BCRank: UInt32, Comparable, CaseIterable {
    /// The rank of 2 (Value 2)
    case two    = 2
    /// The rank of 3 (Value 3)
    case three
    /// The rank of 4 (Value 4)
    case four
    /// The rank of 5 (Value 5)
    case five
    /// The rank of 6 (Value 6)
    case six
    /// The rank of 7 (Value 7)
    case seven
    /// The rank of 8 (Value 8)
    case eight
    /// The rank of 9 (Value 9)
    case nine
    /// The rank of 10 (Value 10)
    case ten
    /// The rank of Jack (Value 11)
    case jack
    /// The rank of Queen (Value 12)
    case queen
    /// The rank of King (Value 13)
    case king
    /// The rank of Ace (Value 14)
    case ace    = 14
    
    public static func < (lhs: BCRank, rhs: BCRank) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    public static func <= (lhs: BCRank, rhs: BCRank) -> Bool {
        return lhs.rawValue <= rhs.rawValue
    }
    
    public static func >= (lhs: BCRank, rhs: BCRank) -> Bool {
        return lhs.rawValue >= rhs.rawValue
    }
    
    public static func > (lhs: BCRank, rhs: BCRank) -> Bool {
        return lhs.rawValue > rhs.rawValue
    }
    
    /// The next rank, cycling from Ace to Two
    func next() -> BCRank {
        switch self {
        case .ace:      return .two
        case .two:      return .three
        case .three:    return .four
        case .four:     return .five
        case .five:     return .six
        case .six:      return .seven
        case .seven:    return .eight
        case .eight:    return .nine
        case .nine:     return .ten
        case .ten:      return .jack
        case .jack:     return .queen
        case .queen:    return .king
        case .king:     return .ace
        }
    }
}

extension BCRank: CustomStringConvertible {
    public var description: String {
        switch self {
        case .ace:      return "A"
        case .two:      return "2"
        case .three:    return "3"
        case .four:     return "4"
        case .five:     return "5"
        case .six:      return "6"
        case .seven:    return "7"
        case .eight:    return "8"
        case .nine:     return "9"
        case .ten:      return "T"
        case .jack:     return "J"
        case .queen:    return "Q"
        case .king:     return "K"
        }
    }
}
