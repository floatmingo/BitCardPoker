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
    
    
    static func combinations<T>(from array: [T], ofSize k: Int) -> [[T]] {
        return combinationsHelper(from: array.dropFirst(0), ofSize: k)
    }

    private static let BC = BinomialCoefficient()
    private static func combinationsHelper<T>(from array: ArraySlice<T>, ofSize k: Int) -> [[T]] {
        if (k <= 0 || array.count < k) {
            return []
        }
        
        if (k == 1) {
            return array.map { [$0] }
        }
        
        if (array.count == k) {
            return [Array(array)]
        }
        
        var index = 0
        var outArray: [[T]] = Array()
        outArray.reserveCapacity(BC.calculate(n: array.count, k: k))
        for item in array {
            let combos = combinationsHelper(from: array.dropFirst(index + 1), ofSize: k - 1)
            index += 1
            
            for combo in combos {
                outArray.append([item] + combo)
            }
        }
        
        
        return outArray
    }
    
}

fileprivate class BinomialCoefficient {
    let size: Int
    var pascalTriangle: [[Int]]
    
    init(size: Int = 25) {
        self.size = size
        
        pascalTriangle = Array(repeating: [], count: size)
        for i in 0..<size { pascalTriangle[i] = Array(repeating: 0, count: size) }
        for line in 0..<size {
            for i in 0...line {
                if line == i || i == 0 { pascalTriangle[line][i] = 1 }
                else { pascalTriangle[line][i] = pascalTriangle[line - 1][i - 1] + pascalTriangle[line - 1][i] }
            }
        }
    }
    
    func calculate(n: Int, k: Int) -> Int {
        if n < 0 || k < 0 || n > 25 || k > 25 {
            return 0
        }
        
        return pascalTriangle[n][k]
    }
}
