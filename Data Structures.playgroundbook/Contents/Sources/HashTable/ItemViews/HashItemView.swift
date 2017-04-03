import UIKit

struct HashItemViewConstants {
    static let height:CGFloat = 30
    static let width:CGFloat = 45
    static let verticalSpacing: CGFloat = 2
}

class HashItemView : UIView {
    let pseudoHash: Int
    
    let kItemHeight: CGFloat = HashItemViewConstants.height
    let kItemWidth: CGFloat = HashItemViewConstants.width
    
    var centerXConstraint: NSLayoutConstraint?
    var centerYConstraint: NSLayoutConstraint?
    
    static var possibleColors = [#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1), #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), #colorLiteral(red: 1, green: 0.4705159068, blue: 0.8073044419, alpha: 1)]
    let color = possibleColors.random
    
    init(hash: Int, hashPresentation: String? = nil) {
        self.pseudoHash = hash
        super.init(frame:.zero)
        self.backgroundColor = UIColor.clear
        self.layer.borderWidth = 2
        self.layer.borderColor = color.cgColor
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant:kItemHeight).isActive = true
        self.widthAnchor.constraint(equalToConstant:kItemWidth).isActive = true
        
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.text = hashPresentation ?? String(hash)
        label.font = label.font.withSize(10)
        
        
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
