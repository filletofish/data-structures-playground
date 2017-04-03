import UIKit

struct KeyItemViewConstants {
    static let height:CGFloat = 30
    static let width:CGFloat = 60
    static let verticalSpacing: CGFloat = 2
}

class KeyItemView : UIView {
    let key: String
    var label: UILabel!
    
    let kItemHeight: CGFloat = KeyItemViewConstants.height
    let kItemWidth: CGFloat = KeyItemViewConstants.width
    
    var centerXConstraint: NSLayoutConstraint?
    var centerYConstraint: NSLayoutConstraint?
    
    init(key: String) {
        self.key = key
        super.init(frame:.zero)
        self.backgroundColor = UIColor.clear
        self.layer.borderWidth = 2
        self.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant:kItemHeight).isActive = true
        self.widthAnchor.constraint(equalToConstant:kItemWidth).isActive = true
        
        label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.text = key
        label.font = label.font.withSize(10)

        
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalTo: widthAnchor, constant: -5).isActive = true
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
