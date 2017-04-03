import Foundation


func randomDirection() -> Int {
    return Int(arc4random_uniform(2) * 2) - 1
}





extension Array {
    var random: Element {
        let randomIndex = Int(arc4random_uniform(UInt32(self.count)))
        return self[randomIndex]
    }
    
    mutating func dropRandom() -> Element {
        let randomIndex = Int(arc4random_uniform(UInt32(self.count)))
        return remove(at: randomIndex)
    }
}
