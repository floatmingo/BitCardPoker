enum BCRank: UInt32, Comparable, CaseIterable {
    case two    = 2
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
    case jack
    case queen
    case king
    case ace    = 14
    
    static func < (lhs: BCRank, rhs: BCRank) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    static func <= (lhs: BCRank, rhs: BCRank) -> Bool {
        return lhs.rawValue <= rhs.rawValue
    }
    
    static func >= (lhs: BCRank, rhs: BCRank) -> Bool {
        return lhs.rawValue >= rhs.rawValue
    }
    
    static func > (lhs: BCRank, rhs: BCRank) -> Bool {
        return lhs.rawValue > rhs.rawValue
    }
    
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
    var description: String {
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
