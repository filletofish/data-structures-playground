import Foundation

struct Queue<Element> {
    private var stack1: Stack<Element> = Stack()
    private var stack2: Stack<Element> = Stack()
    
    var items: [Element] {
        return stack2.items.reversed() + stack1.items
    }
    
    /// O(1) on stack arrays conforming to RandomAccessCollection protocol
    var count: Int {
        return stack1.items.count + stack2.items.count
    }
    
    /// O(1) complexity
    mutating func enqueue(_ element: Element) {
        stack1.push(element)
    }
    
    /// Complexity: Amortized O(1) over many dequeueings.
    mutating func dequeue() -> Element {
        if (stack2.items.isEmpty) {
            while !stack1.items.isEmpty {
                stack2.push(stack1.pop())
            }
        }
        return stack2.pop()
    }
}
