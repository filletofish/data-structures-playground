import UIKit

public class NicyHashTableViewController: HashTableViewController {

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.hashFunction = { keyView -> Int in
            return keyView.key.hashValue
        }
    }
    
    func convert(hash: Int) -> String {
        return "hash #\(hashViewsDictionary.count + 1)"
    }
    
    override func createHashItemView(withHash hash: Int) -> HashItemView {
        return HashItemView(hash: hash, hashPresentation: convert(hash: hash))
    }
}

