/*:
 
 Hash table (hash map) is a data structure used to implement an associative array, a structure that can map keys to values. A hash table uses a hash function to compute an index into an array of buckets, from which the desired value can be found.
 
 Ideally, the hash function will assign each key to a unique bucket, but most hash table designs employ an imperfect hash function,
 which might cause hash collisions. Collision happens when the hash function generates the same index for more than one key. Such
 collisions must be accommodated in some way.
 
 A good hash function and implementation algorithm are essential for good hash table performance, but may be difficult to achieve.
 
 Apparently Dictionary in swift language is a Hash Table.
 
 **Application**:
 Hash tables are everywhere, if you've done any programming at all you must have seen them appear time and again!
 
 Hash tables allow you to store a bunch of objects in such a way that you can later find them again very quickly.
 
 **It's your turn:**
 
 1. Create a table mapping name of emoji (`String`) to emoji symbol itself (`Character`)
 2. Use `insert` to add key-value pairs to table
 3. If you messed up, use `clear` to delete all entries
 4. Note that there is no collisions at all
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
insert(forKey: "thumbUp", value: "👍")
insert(forKey: "sadness", value: "😰")
//#-end-editable-code




