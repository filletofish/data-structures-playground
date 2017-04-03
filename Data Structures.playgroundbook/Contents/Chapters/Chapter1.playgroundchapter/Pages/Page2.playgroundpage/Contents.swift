/*:
 A queue is an another particular kind of data structure. All elements in queue are kept in order.
 The queue is a First-In-First-Out (FIFO) data structure. In a FIFO data structure, the first element added to the queue will be
 the first one to be removed. This is equivalent to the requirement that once a new element is added, all elements that were added
 before have to be removed before the new element can be removed.
 
 Applications:
 * CPU scheduling, Disk Scheduling
 * Any other multitask work, like multiprocessing (where the first one to be entered is the first to be processed)
 
 **Try this:**
 
 1. Create a queue of these cats
 2. Use `enqueue` to put cat in queue.
 3. `dequeue` to get out.
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
func enqueue(_ cat: Cat) {
    let page = PlaygroundPage.current
    if let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy {
        let message: PlaygroundValue = .string(cat.rawValue)
        proxy.send(message)
    }
}
func dequeue() {
    let page = PlaygroundPage.current
    if let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy {
        let message: PlaygroundValue = .array([])
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

enqueue(grumpyCat)
enqueue(dodgyCat)
dequeue()
//#-end-editable-code

