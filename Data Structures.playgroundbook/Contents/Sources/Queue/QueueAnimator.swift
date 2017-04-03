import UIKit

class QueueAnimator: Animator {
    fileprivate let kItemWidth = QueueItemViewConstants.width
    fileprivate let kItemSpacing = QueueItemViewConstants.spacing
    
    
    func enqueue(_ itemView: QueueItemView) {
        guard let vc = viewController as? QueueViewController else { return }
        let restCount = vc.kMaxItemsCount - vc.queue.count
        
        self.add { [unowned self] in
            self.startedCallback()
            UIView.animate(withDuration: 2.0, animations: {
                
                let constant = CGFloat(restCount) * self.kItemWidth + CGFloat(restCount - 1) * self.kItemSpacing
                itemView.trailingConstraint?.constant = constant
                itemView.alpha = 1.0
                vc.view.layoutIfNeeded()
            }, completion: { _ in
                self.completedCallback()
            })
        }
    }
    
    
    func dequeue(_ itemView: QueueItemView) {
        guard let vc = viewController as? QueueViewController else { return }
        let items = vc.queue.items
        
        self.add { [unowned self] in
            self.startedCallback()
            UIView.animate(withDuration: 1.0, animations: {
                
                let constant = vc.containerWidth + self.kItemWidth
                itemView.trailingConstraint?.constant = constant
                itemView.alpha = 0.0
                vc.view.layoutIfNeeded()
            }, completion: { _ in
                self.completedCallback()
            })
        }
        
        self.add { [unowned self] in
            let queueStep = self.kItemWidth + self.kItemSpacing
            
            UIView.animate(withDuration: 1.0, animations: {
                items.forEach { $0.trailingConstraint?.constant += queueStep }
                vc.view.layoutIfNeeded()
            }, completion: { _ in
                self.completedCallback()
            })
        }
    }
}
