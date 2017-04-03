import UIKit

public class DequeViewController: QueueViewController {
    
    var deque: Deque<DequeItemView> = Deque()
    
    fileprivate lazy var dequeAnimator: DequeAnimator = {
        return DequeAnimator(self)
    }()
    
    @available(*, unavailable, message:"Use pushBack or pushFront instead")
    override public func enqueue(_ catName: String) {
    }
    
    @available(*, unavailable, message:"Use popBack or popFront instead")
    override public func dequeue() -> String? {
        return nil
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func pushBack(_ item: String) {
        let itemView = DequeItemView(item: item)
        itemView.alpha = 0.0
        view.addSubview(itemView)
        setConstraints(for: itemView, fromFront: false)
        dequeAnimator.push(itemView, fromFront: false)
        deque.pushBack(itemView)
    }
    
    public override func pushFront(_ item: String) {
        let itemView = DequeItemView(item: item)
        itemView.alpha = 0.0
        view.addSubview(itemView)
        setConstraints(for: itemView, fromFront: true)
        dequeAnimator.push(itemView, fromFront: true)
        deque.pushFront(itemView)
    }
    
    public override func popFront() -> String? {
        guard !deque.isEmpty else { return nil }
        let itemView = deque.popFront()
        dequeAnimator.pop(itemView, fromFront: true)
        return itemView.item
    }
    
    public override func popBack() -> String? {
        guard !deque.isEmpty else { return nil }
        let itemView = deque.popBack()
        dequeAnimator.pop(itemView, fromFront: false)
        return itemView.item
    }
    
    fileprivate func setConstraints(for itemView: DequeItemView, fromFront: Bool) {
        itemView.centerYConstraint = itemView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        itemView.centerYConstraint!.isActive = true
        itemView.centerXConstraint = itemView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        itemView.centerXConstraint?.isActive = true
        
        let absoluteOffset = containerWidth / 2 + kItemWidth / 2
        itemView.centerXConstraint?.constant = fromFront ? absoluteOffset : -absoluteOffset
        view.layoutIfNeeded()
    }
}

