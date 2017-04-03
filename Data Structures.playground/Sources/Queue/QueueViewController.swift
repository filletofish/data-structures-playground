import UIKit


public class QueueViewController: UIViewController {
    var queue: Queue<QueueItemView> = Queue()
    let kMaxItemsCount:Int = 5
    var containerView: QueueContainerView!
    let kContainerThickness: CGFloat = 20
    let kContainerItemVerticalSpacing:CGFloat = 2
    
    let kItemHeight: CGFloat = QueueItemViewConstants.height
    let kItemWidth: CGFloat = QueueItemViewConstants.width
    let kItemSpacing: CGFloat = QueueItemViewConstants.spacing
    
    var containerWidth: CGFloat {
        return CGFloat(kMaxItemsCount) * kItemWidth + CGFloat(kMaxItemsCount - 1) * kItemSpacing
    }
    
    var containerHeight: CGFloat {
        return kItemHeight + 2 * kContainerThickness + 2 * kContainerItemVerticalSpacing
    }
    
    fileprivate lazy var animator: QueueAnimator = {
        return QueueAnimator(self)
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        setupContainer()
    }
    
    fileprivate func setupContainer() {
        let containerFrame = CGRect(origin: .zero, size: CGSize(width: containerWidth, height: containerHeight))
        containerView = QueueContainerView(frame: containerFrame, thickness: kContainerThickness)
        view.addSubview(containerView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: containerWidth).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: containerHeight).isActive = true
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    fileprivate func setInitialConstraints(for itemView: QueueItemView) {
        itemView.centerYConstraint = itemView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        itemView.centerYConstraint!.isActive = true
        itemView.trailingConstraint = itemView.trailingAnchor.constraint(equalTo: containerView.leadingAnchor)
        itemView.trailingConstraint?.isActive = true
        view.layoutIfNeeded()
    }
    
    public func enqueue(_ catName: String) {
        let itemView = QueueItemView(item: catName)
        itemView.alpha = 0
        view.addSubview(itemView)
        setInitialConstraints(for: itemView)
        animator.enqueue(itemView)
        queue.enqueue(itemView)
    }
    
    public func dequeue() -> String? {
        guard queue.count > 0 else { return nil }
        let dequeued = queue.dequeue()
        animator.dequeue(dequeued)
        return dequeued.item
    }
    
    
    // dummy implementation for subclass DequeViewController
    public func pushBack(_ item: String) {
       
    }
    
    public func pushFront(_ item: String) {
        
    }
    
    public func popFront() -> String? {
        return nil
    }
    
    public func popBack() -> String? {
        return nil
    }
}
