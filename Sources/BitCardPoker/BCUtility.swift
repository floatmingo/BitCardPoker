public class BCUtility {
    public static func makeCardArray(from input: String) -> [BCCard]? {
        var cards: [BCCard] = Array()
        let cardStrings = input.split(separator: " ")
        
        if !(cardStrings.count == 5 || cardStrings.count == 7) {
            return nil
        }
        
        for cardStr in cardStrings {
            if cardStr.count != 2 {
                return nil
            }
            
            var rank: BCRank
            var suit: BCSuit
            
            switch cardStr.first {
            case "2": rank = .two
            case "3": rank = .three
            case "4": rank = .four
            case "5": rank = .five
            case "6": rank = .six
            case "7": rank = .seven
            case "8": rank = .eight
            case "9": rank = .nine
            case "T", "t": rank = .ten
            case "J", "j": rank = .jack
            case "Q", "q": rank = .queen
            case "K", "k": rank = .king
            case "A", "a": rank = .ace
            default: return nil
            }
            
            switch cardStr.last {
            case "H", "h": suit = .hearts
            case "D", "d": suit = .diamonds
            case "C", "c": suit = .clubs
            case "S", "s": suit = .spades
            default: return nil
            }
            
            cards.append(BCCard(rank: rank, suit: suit))
        }
        
        return cards
    }
    
    
    static func combinations<T>(from array: [T], ofSize r: Int) -> [[T]] {
        return combinationsHelper(from: array.dropFirst(0), ofSize: r)
    }
    
    private static func combinationsHelper<T>(from array: ArraySlice<T>, ofSize r: Int) -> [[T]] {
        if (r <= 0 || array.count < r) {
            return []
        }
        
        if (r == 1) {
            return array.map { [$0] }
        }
        
        if (array.count == r) {
            return [Array(array)]
        }
        
        var index = 0
        return array.reduce([], { result, item in
            let combos = combinationsHelper(from: array.dropFirst(index + 1), ofSize: r - 1)
            index += 1
            
            return result + combos.map { combo in [item] + combo }
        })
    }
    
}
