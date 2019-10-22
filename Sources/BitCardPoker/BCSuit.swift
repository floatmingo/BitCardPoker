//
//  BCSuit.swift
//  BitCardPoker
//
//  Created by William Oropallo on 10/19/19.
//  Copyright © 2019 Oropallo Dev. All rights reserved.
//

enum BCSuit: UInt8, Comparable, CaseIterable {
    case hearts
    case diamonds
    case clubs
    case spades
    
    static func < (lhs: BCSuit, rhs: BCSuit) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    static func <= (lhs: BCSuit, rhs: BCSuit) -> Bool {
        return lhs.rawValue <= rhs.rawValue
    }
    
    static func >= (lhs: BCSuit, rhs: BCSuit) -> Bool {
        return lhs.rawValue >= rhs.rawValue
    }
    
    static func > (lhs: BCSuit, rhs: BCSuit) -> Bool {
        return lhs.rawValue > rhs.rawValue
    }
}

extension BCSuit: CustomStringConvertible {
    var description: String {
        get {
            switch self {
            case .hearts:   return "H"
            case .diamonds: return "D"
            case .clubs:    return "C"
            case .spades:   return "S"
            }
        }
    }
    
    var characterIcon: String {
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
