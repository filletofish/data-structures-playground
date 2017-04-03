import UIKit

struct StackItemViewConstants {
    static let height: CGFloat = 40
    static let width: CGFloat = 100
    static let spacing: CGFloat = 3
}

class StackItemView: UIView {
    let item: Int
    let kItemHeight: CGFloat = StackItemViewConstants.height
    let kItemWidth: CGFloat = StackItemViewConstants.width

    var alignXConstraint: NSLayoutConstraint?
    var bottomConstraint: NSLayoutConstraint?
    
    init(item: Int) {
        self.item = item
        super.init(frame:.zero)
        self.backgroundColor = UIColor.clear
        self.layer.borderWidth = 2
        self.layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1).cgColor
        self.layer.cornerRadius = kItemHeight / 4
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant:kItemHeight).isActive = true
        self.widthAnchor.constraint(equalToConstant:kItemWidth).isActive = true
        
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.text = String(item)
        
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
