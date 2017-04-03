/*:
 
 Hash collisions are practically unavoidable when hashing a random subset of a large set of possible keys. Therefore, almost all
 hash table implementations have some collision resolution strategy to handle such events. One of the common strategy - separate
 chaining is described.
 
 In this method each bucket is independent, and has some sort of list of entries with the same index (results of hash functions).
 
 In a good hash table, each bucket has zero or one entries, and sometimes two or three, but rarely more than that.
 
 Now I created for you a table with bad hash function: it produces hash based on key length.
 
 **Test it:**
 
 1. Run written to code to see a collision
 2. This is an example of a bad hash function 
 */
//#-hidden-code
import PlaygroundSupport
func insert(forKey key: String, value: Character) {
    let page = PlaygroundPage.current
    if let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy {
        let dict = ["key": PlaygroundValue.string(key),
                    "value": PlaygroundValue.string(String(value))]
        let message: PlaygroundValue = .dictionary(dict)
        proxy.send(message)
    }
}
func clear() {
    let page = PlaygroundPage.current
    if let proxy = page.liveView as? PlaygroundRemoteLiveViewProxy {
        let message: PlaygroundValue = .integer(0)
        proxy.send(message)
    }
}
//#-end-hidden-code
//#-code-completion(everything, hide)
//#-code-completion(currentmodule, show)
//#-editable-code
insert(forKey: "Melon", value: "🍈")
insert(forKey: "Lemon", value: "🍋")
insert(forKey: "Tomato", value:"🍅")
insert(forKey: "Tomato", value:"🍆")
//#-end-editable-code




