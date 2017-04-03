import Foundation
import UIKit

struct Stack<Element> {
    var items = [Element]()
    
    var isEmpty: Bool { return items.isEmpty }
    
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }
}
