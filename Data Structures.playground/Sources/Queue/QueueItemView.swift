import UIKit

struct QueueItemViewConstants {
    static let height: CGFloat = 150
    static let width: CGFloat = 60
    static let spacing: CGFloat = 3
}

class QueueItemView: UIView {
    let item: String
    let kItemHeight: CGFloat = QueueItemViewConstants.height
    let kItemWidth: CGFloat = QueueItemViewConstants.width
    
    var trailingConstraint: NSLayoutConstraint?
    var centerYConstraint: NSLayoutConstraint?
    var borderColor: CGColor { return #colorLiteral(red: 0.05283724517, green: 0.8756095171, blue: 0.7205693126, alpha: 1).cgColor }
    
    init(item: String) {
        self.item = item
        super.init(frame:.zero)
        self.backgroundColor = UIColor.clear
        self.layer.borderWidth = 2
        self.layer.borderColor = borderColor
        self.layer.cornerRadius = kItemWidth / 4
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant:kItemHeight).isActive = true
        self.widthAnchor.constraint(equalToConstant:kItemWidth).isActive = true
        
        let imageView = UIImageView(image: UIImage(named: item))
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        
//        
//        let label = UILabel(frame: .zero)
//        label.textAlignment = .center
//        label.text = String(item)
//        
//        self.addSubview(label)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        
//        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

