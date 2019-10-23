public enum BCSuit: UInt8, Comparable, CaseIterable {
    case hearts
    case diamonds
    case clubs
    case spades
    
    public static func < (lhs: BCSuit, rhs: BCSuit) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    public static func <= (lhs: BCSuit, rhs: BCSuit) -> Bool {
        return lhs.rawValue <= rhs.rawValue
    }
    
    public static func >= (lhs: BCSuit, rhs: BCSuit) -> Bool {
        return lhs.rawValue >= rhs.rawValue
    }
    
    public static func > (lhs: BCSuit, rhs: BCSuit) -> Bool {
        return lhs.rawValue > rhs.rawValue
    }
}

extension BCSuit: CustomStringConvertible {
    public var description: String {
        get {
            switch self {
            case .hearts:   return "H"
            case .diamonds: return "D"
            case .clubs:    return "C"
            case .spades:   return "S"
            }
        }
    }
    
    public var character: Character {
        get {
            switch self {
            case .hearts:   return "♥"
            case .diamonds: return "♦"
            case .clubs:    return "♣"
            case .spades:   return "♠"
            }
        }
    }
}
