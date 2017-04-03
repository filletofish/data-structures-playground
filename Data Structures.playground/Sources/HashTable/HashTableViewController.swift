import UIKit

public class HashTableViewController: UIViewController {
    
    let itemsHorizontalSpacing: CGFloat  = 2.0
    
    var container: UIView!
    var header: UIView!
    
    var containerWidth: CGFloat {return KeyItemViewConstants.width + RelationsViewConstants.width + HashItemViewConstants.width + CGFloat(maxSize) * ValueItemViewConstants.width + itemsHorizontalSpacing * CGFloat(maxSize + 1)}
    var containerHeight: CGFloat {return (KeyItemViewConstants.height + KeyItemViewConstants.verticalSpacing) * CGFloat(maxSize) - KeyItemViewConstants.verticalSpacing  }
    
    let maxSize = 5
    var hashFunction: (KeyItemView) -> Int = { return $0.key.characters.count }
    var table: Dictionary<KeyItemView, ValueItemView> = Dictionary()
    var hashViewsDictionary: Dictionary<HashItemView, [(KeyItemView, ValueItemView)]> = Dictionary()
    
    lazy fileprivate var animator: HashTableAnimator = {
        return HashTableAnimator(self)
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupContainer()
        setupHeader()
    }
    
    fileprivate func setupHeader() {
        header = UIView()
        header.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(header)
        header.widthAnchor.constraint(equalTo: container.widthAnchor).isActive = true
        header.heightAnchor.constraint(equalToConstant: 80).isActive = true
        header.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        header.bottomAnchor.constraint(equalTo: container.topAnchor).isActive = true
        
        let keyLabel = UILabel()
        keyLabel.text = "Key"
        let valueLabel = UILabel()
        valueLabel.text = "Value"
        let hashLabel = UILabel()
        hashLabel.text = "Hash"
        
        [keyLabel, valueLabel, hashLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            header.addSubview($0)
            $0.centerYAnchor.constraint(equalTo: header.centerYAnchor).isActive = true
        }
        let keyLeadingOffset = KeyItemViewConstants.width / 2
        keyLabel.centerXAnchor.constraint(equalTo: header.leadingAnchor, constant: keyLeadingOffset).isActive = true
        
        let hashLeadingOffset = KeyItemViewConstants.width + (RelationsViewConstants.width + HashItemViewConstants.width) / 2
        hashLabel.centerXAnchor.constraint(equalTo: header.leadingAnchor, constant: hashLeadingOffset).isActive = true
        
        let valueLeadingOffset = KeyItemViewConstants.width + (RelationsViewConstants.width + HashItemViewConstants.width) + (CGFloat(maxSize) * ValueItemViewConstants.width + itemsHorizontalSpacing * CGFloat(maxSize + 1)) / 2
        valueLabel.centerXAnchor.constraint(equalTo: header.leadingAnchor, constant: valueLeadingOffset).isActive = true
    }
    
    fileprivate func setupContainer() {
        container = UIView()
        view.addSubview(container)

        container.translatesAutoresizingMaskIntoConstraints = false
        container.widthAnchor.constraint(equalToConstant: containerWidth).isActive = true
        container.heightAnchor.constraint(equalToConstant: containerHeight).isActive = true
        container.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        container.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    fileprivate func setConstraints(for keyView: KeyItemView) {
        keyView.translatesAutoresizingMaskIntoConstraints = false
        keyView.centerXConstraint = keyView.centerXAnchor.constraint(equalTo: container.leadingAnchor, constant: KeyItemViewConstants.width / 2)
        let topOffset = CGFloat(table.count) * (KeyItemViewConstants.height + KeyItemViewConstants.verticalSpacing)
        keyView.centerYConstraint = keyView.centerYAnchor.constraint(equalTo: container.topAnchor, constant: topOffset)
        keyView.centerYConstraint?.isActive = true
        keyView.centerXConstraint?.isActive = true
        view.layoutIfNeeded()
    }
    
    fileprivate func setConstraints(for hashView: HashItemView) {
        hashView.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingOffset = KeyItemViewConstants.width + RelationsViewConstants.width + HashItemViewConstants.width / 2
        hashView.centerXConstraint = hashView.centerXAnchor.constraint(equalTo: container.leadingAnchor, constant: leadingOffset)
        
        let topOffset = CGFloat(table.count) * (HashItemViewConstants.height + HashItemViewConstants.verticalSpacing)
        hashView.centerYConstraint = hashView.centerYAnchor.constraint(equalTo: container.topAnchor, constant: topOffset)
        hashView.centerYConstraint?.isActive = true
        hashView.centerXConstraint?.isActive = true
        view.layoutIfNeeded()
    }
    
    fileprivate func setConstraints(for valueView: ValueItemView, depending hashView: HashItemView) {
        valueView.translatesAutoresizingMaskIntoConstraints = false
        let otherValuesCount = hashViewsDictionary[hashView]?.count ?? 0
        let leadingOffset = ValueItemViewConstants.width / 2 + itemsHorizontalSpacing + CGFloat(otherValuesCount) * (ValueItemViewConstants.width + itemsHorizontalSpacing)
        valueView.centerXConstraint = valueView.centerXAnchor.constraint(equalTo: hashView.trailingAnchor, constant: leadingOffset)
        
        valueView.centerYConstraint = valueView.centerYAnchor.constraint(equalTo: hashView.centerYAnchor)
        valueView.centerYConstraint?.isActive = true
        valueView.centerXConstraint?.isActive = true
        view.layoutIfNeeded()
    }
    
    func createHashItemView(withHash hash: Int) -> HashItemView {
        print("hash = \(hash)")
        return HashItemView(hash: hash)
    }
    
    fileprivate func getHashItemView(forHashValue hashValue: Int) -> HashItemView {
        if let hashView = hashViewsDictionary.keys.first(where: { $0.pseudoHash == hashValue }) {
            return hashView
        } else {
            let hashView = createHashItemView(withHash: hashValue)
            hashView.alpha = 0.0
            view.addSubview(hashView)
            setConstraints(for: hashView)
            animator.animateInserting(hashView)
            hashViewsDictionary[hashView] = []
            return hashView
        }
    }
    
    public func insert(key: String, value: Character) {
        guard table.count < maxSize else { return }
        if let (_, valueView) = table.first(where: { keyView, _ -> Bool in
            return keyView.key == key
        }) {
            animator.updateValue(in: valueView, with: value)
        } else {
            let keyView = KeyItemView(key: key)
            keyView.alpha = 0.0
            view.addSubview(keyView)
            setConstraints(for: keyView)
            animator.animateInserting(keyView)
            let hashValue = hashFunction(keyView)
            let hashView = getHashItemView(forHashValue: hashValue)
            animator.animateCreatingRelation(from: keyView, to: hashView)
            let valueView = ValueItemView(value: value)
            valueView.alpha = 0.0
            view.addSubview(valueView)
            setConstraints(for: valueView, depending: hashView)
            animator.animateInserting(valueView)
            table[keyView] = valueView
            hashViewsDictionary[hashView]?.append(keyView, valueView)
        }
        
    }
    
    public func clear() {
        
        animator.clear()
        table.removeAll()
        hashViewsDictionary.removeAll()
    }

}

