class BCUtility {
    static func makeCardArray(from input: String) -> [BCCard]? {
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
    
    
    static func combinations<T>(from array: [T], ofSize k: Int) -> [[T]] {
        return combinationsHelper(from: array.dropFirst(0), ofSize: k)
    }

    private static func combinationsHelper<T>(from array: ArraySlice<T>, ofSize k: Int) -> [[T]] {
        if (k <= 0 || array.count < k) { return [] }
        if (k == 1) { return array.map { [$0] } }
        if (array.count == k) { return [Array(array)] }
        
        var index = 0
        var outArray: [[T]] = Array()
        for item in array {
            let combos = combinationsHelper(from: array.dropFirst(index + 1), ofSize: k - 1)
            index += 1
            
            for combo in combos { outArray.append([item] + combo) }
        }
        
        
        return outArray
    }
    
    static func combinations7to5<T>(from array: [T]) -> [[T]] {
        if array.count != 7 { return [] }
        
        return [
            [array[0], array[1], array[2], array[3], array[4]],
            [array[0], array[1], array[2], array[3], array[5]],
            [array[0], array[1], array[2], array[3], array[6]],
            [array[0], array[1], array[2], array[4], array[5]],
            [array[0], array[1], array[2], array[4], array[6]],
            [array[0], array[1], array[2], array[5], array[6]],
            [array[0], array[1], array[3], array[4], array[5]],
            [array[0], array[1], array[3], array[4], array[6]],
            [array[0], array[1], array[3], array[5], array[6]],
            [array[0], array[1], array[4], array[5], array[6]],
            [array[0], array[2], array[3], array[4], array[5]],
            [array[0], array[2], array[3], array[4], array[6]],
            [array[0], array[2], array[3], array[5], array[6]],
            [array[0], array[2], array[4], array[5], array[6]],
            [array[0], array[3], array[4], array[5], array[6]],
            [array[1], array[2], array[3], array[4], array[5]],
            [array[1], array[2], array[3], array[4], array[6]],
            [array[1], array[2], array[3], array[5], array[6]],
            [array[1], array[2], array[4], array[5], array[6]],
            [array[1], array[3], array[4], array[5], array[6]],
            [array[2], array[3], array[4], array[5], array[6]]
        ]
    }
}
