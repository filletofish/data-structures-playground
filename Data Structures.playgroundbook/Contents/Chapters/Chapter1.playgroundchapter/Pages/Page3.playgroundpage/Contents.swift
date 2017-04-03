/*:
 A double-ended queue (dequeue, often abbreviated to deque) is an data structure that generalizes a queue, for which elements can
 be added to or removed from either the front (head) or back (tail).
 
 **Cats again:**
 
 1. Consider the same cats as on previuos page
 2. But now use `pushBack`, `pushFront` to put cat in dequeue from back and front
 3. `popBack` and `popFront` is for popping cats from different sides
 */
//#-hidden-code
import PlaygroundSupport
enum Cat: String {
    case bally = "cat1"
    case dodgy = "cat2"
    case waity = "cat3"
    case grumpy = "cat4"
    case jumpy = "cat5"
}
func pushBack(_ cat: Cat) {
    let page = PlaygroundPage.current
    if let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy {
        let dict = ["cat": PlaygroundValue.string(cat.rawValue),
                    "command": PlaygroundValue.integer(-1)]
        let message: PlaygroundValue = .dictionary(dict)
        proxy.send(message)
    }
}
func pushFront(_ cat: Cat) {
    let page = PlaygroundPage.current
    if let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy {
        let dict = ["cat": PlaygroundValue.string(cat.rawValue),
                    "command": PlaygroundValue.integer(1)]
        let message: PlaygroundValue = .dictionary(dict)
        proxy.send(message)
    }
}
func popBack() {
    let page = PlaygroundPage.current
    if let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy {
        let message: PlaygroundValue = .integer(-1)
        proxy.send(message)
    }
}
func popFront() {
    let page = PlaygroundPage.current
    if let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy {
        let message: PlaygroundValue = .integer(1)
        proxy.send(message)
    }
}
//#-end-hidden-code
//#-code-completion(everything, hide)
//#-code-completion(currentmodule, show)
//#-editable-code
let ballyCat = Cat.bally
let grumpyCat = Cat.grumpy
let waityCat = Cat.waity
let dodgyCat = Cat.dodgy
let jumpyCat = Cat.jumpy

pushFront(grumpyCat)
pushBack(dodgyCat)
pushFront(jumpyCat)
popBack()
//#-end-editable-code



