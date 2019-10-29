/// An enum that represents a the four French playing cards suits.
public enum BCSuit: UInt8, Comparable, CaseIterable {
    /// The suit of hearts (♥)
    case hearts
    
    /// The suit of diamonds (♦)
    case diamonds
    
    /// The suit of clubs (♣)
    case clubs
    
    /// The suit of spades (♠)
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
    
    /// The string character representing the suit
    public var character: String {
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
