import UIKit

public class StackViewController: UIViewController {
    
    let kContainerBottomOffset: CGFloat = 200
    
    let kItemHeight: CGFloat = StackItemViewConstants.height
    let kItemWidth: CGFloat = StackItemViewConstants.width
    let kItemSpacing: CGFloat = StackItemViewConstants.spacing
    
    let kItemAndContainerSpacing: CGFloat = 2
    let kFirstItemOffset: CGFloat = 2
    
    var stack = Stack<StackItemView>()
    let maxStackSize = 5
    
    var containerView: UIView!
    var containerThickness: CGFloat { return kItemWidth / 4 }
    var containerHeight: CGFloat {
        return CGFloat(maxStackSize) * (kItemHeight + kItemSpacing) + containerThickness + kFirstItemOffset
    }
    var containerWidth: CGFloat { return kItemWidth + 2 * containerThickness + 2 * kItemAndContainerSpacing  }
    
    private lazy var animator: StackAnimator = {
        return StackAnimator(self)
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupContainer()
    }
    
    private func setupContainer() {
        let containerFrame = CGRect(origin: .zero, size: CGSize(width: containerWidth, height: containerHeight))
        print(containerFrame)
        containerView = StackContainerView(frame: containerFrame, thickness: containerThickness)
        view.addSubview(containerView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -kContainerBottomOffset).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: containerWidth).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: containerHeight).isActive = true
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setInitialConstraints(for itemView: StackItemView) {
        let fromContainerOffset = -(kItemSpacing + kItemHeight)
        itemView.bottomConstraint = itemView.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: fromContainerOffset)
        itemView.bottomConstraint!.isActive = true

        itemView.alignXConstraint = itemView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        itemView.alignXConstraint!.isActive = true
        view.layoutIfNeeded()
    }
    
    public func push(_ item: Int) {
        guard stack.items.count < maxStackSize else {return}
        
        let itemView = StackItemView(item: item)
        itemView.alpha = 0
        view.addSubview(itemView)
        setInitialConstraints(for: itemView)
        animator.push(itemView)
        stack.push(itemView)
    }
    
    public func pop() -> Int? {
        guard stack.items.count > 0 else {return nil}
        let itemView = stack.pop()
        animator.pop(itemView)
        return itemView.item
    }
}
