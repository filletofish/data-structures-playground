import UIKit

struct ValueItemViewConstants {
    static let height:CGFloat = 30
    static let width:CGFloat = 30
    static let verticalSpacing: CGFloat = 2
}

class ValueItemView : UIView {
    var value: Character
    let kItemHeight: CGFloat = ValueItemViewConstants.height
    let kItemWidth: CGFloat = ValueItemViewConstants.width
    
    var centerXConstraint: NSLayoutConstraint?
    var centerYConstraint: NSLayoutConstraint?
    
    var label: UILabel!
    
    init(value: Character) {
        self.value = value
        super.init(frame:.zero)
        self.backgroundColor = UIColor.clear
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        self.layer.cornerRadius = kItemHeight / 4
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant:kItemHeight).isActive = true
        self.widthAnchor.constraint(equalToConstant:kItemWidth).isActive = true
        
        label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.text = String(value)
        label.font = label.font.withSize(10)
        
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func updateValue(_ value: Character) {
        self.value = value
        self.label.text = String(value)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
