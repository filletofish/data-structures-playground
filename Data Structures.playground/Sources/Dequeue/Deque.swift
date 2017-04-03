import Foundation

struct Deque<Element> {
    var leftStack: Stack<Element> = Stack()
    var rightStack: Stack<Element> = Stack()
    
    
    var count: Int {
        return leftStack.items.count + rightStack.items.count
    }
    
    var items: [Element] {
        return rightStack.items.reversed() + leftStack.items
    }
    
    var isEmpty: Bool {
        return count == 0
    }
    
    mutating func pushFront(_ item: Element) {
        rightStack.push(item)
    }
    
    mutating func pushBack(_ item: Element) {
        leftStack.push(item)
    }
    
    mutating func popFront() -> Element {
        guard rightStack.isEmpty else { return rightStack.pop() }
        
        let size = leftStack.items.count
        var local = Stack<Element>()
        
        for _ in (0..<size / 2) {
            local.push(leftStack.pop())
        }
        while !leftStack.isEmpty {
            rightStack.push(leftStack.pop())
        }
        while !local.isEmpty {
            leftStack.push(local.pop())
        }
        return rightStack.pop()
    }
    
    mutating func popBack() -> Element {
        guard leftStack.isEmpty else { return leftStack.pop() }
        print("a")
        let size = rightStack.items.count
        var local = Stack<Element>()
        print("size = \(size))")
        for i in (0..<size / 2) {
            print("i = \(i)")
            local.push(rightStack.pop())
        }
        print("b")

        while !rightStack.isEmpty {
            leftStack.push(rightStack.pop())
        }
        print("c")

        while !local.isEmpty {
            rightStack.push(local.pop())
        }
        print("d")

        return leftStack.pop()
    }
}
