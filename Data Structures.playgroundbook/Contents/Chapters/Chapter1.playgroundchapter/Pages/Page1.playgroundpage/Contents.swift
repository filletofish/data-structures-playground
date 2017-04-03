/*:
 
 So this is your first data structure - Stack.
 
 A stack is a data structure that serves as a collection of elements, with two principal operations:
 * push - which adds an element to the collection
 * pop, which removes the most recently added element that was not yet removed.
 
 The order in which elements come off a stack gives rise to its alternative name, _LIFO_ (last in, first out).
 
 The name "stack" for this type of structure comes from the analogy to a set of physical items stacked on top of each other, which
 makes it easy to take an item off the top of the stack, while getting to an item deeper in the stack may require taking off 
 multiple other items first.
 
 Applications: 
 * Runtime memory management
 * Calculators use stack to hold expressions
 * Any function call in your program goes with pushing it on stack
 * UIViewControllers in UIKit are holded in stack
 
 **Try this:**
 
 1. `Push` some integers to stack.
 2. Use `pop` to get them out of stack.
 3. Repeat it a few times. Don't forget that stack has a limit.
 */
//#-hidden-code
import PlaygroundSupport
func push(_ item: Int) {
    let page = PlaygroundPage.current
    if let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy {
        let message: PlaygroundValue = .integer(item)
        proxy.send(message)
    }
}
func pop() {
    let page = PlaygroundPage.current
    if let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy {
        let message: PlaygroundValue = .string("pop")
        proxy.send(message)
    }
}
//#-end-hidden-code
//#-code-completion(everything, hide)
//#-code-completion(currentmodule, show)
//#-editable-code
push(3)
pop()
//#-end-editable-code

