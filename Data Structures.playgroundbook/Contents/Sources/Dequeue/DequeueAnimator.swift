import UIKit

class DequeAnimator: Animator {
    fileprivate let kItemWidth = QueueItemViewConstants.width
    fileprivate let kItemSpacing = QueueItemViewConstants.spacing
    
    func adjust(itemViews: [DequeItemView], backward: Bool) {
        guard let vc = viewController as? DequeViewController else { return }
        self.add {
            self.startedCallback()
            UIView.animate(withDuration: 0.5, animations: {
                let absoluteOffset = (self.kItemSpacing + self.kItemWidth) / 2
                let offset = backward ? -absoluteOffset : absoluteOffset
                
                itemViews.forEach { $0.centerXConstraint?.constant += offset }
                vc.view.layoutIfNeeded()
            }, completion: { _ in
                self.completedCallback()
            })
        }
    }
    
    func push(_ itemView: DequeItemView, fromFront: Bool) {
        guard let vc = viewController as? DequeViewController else { return }
        
        guard vc.deque.count > 0 else {
            self.add {
                self.startedCallback()
                UIView.animate(withDuration: 0.5, animations: {
                    itemView.centerXConstraint?.constant = 0
                    itemView.alpha = 1.0
                    vc.view.layoutIfNeeded()
                }, completion: { _ in
                    self.completedCallback()
                })
            }
            return
        }
        
        let isEvenItemCorrection: CGFloat = vc.deque.count % 2 == 0 ? -0.5 : 0.0
        
        let currentItemIndexFromSide = vc.deque.count / 2 + 1
        let items = vc.deque.items
        
        self.add { [unowned self] in
            self.startedCallback()
            UIView.animate(withDuration: 0.5, animations: {
                let offsetPerItem = self.kItemWidth + self.kItemSpacing
                let absoluteCenterXOffset = (CGFloat(currentItemIndexFromSide) + isEvenItemCorrection) * offsetPerItem
                itemView.centerXConstraint?.constant = fromFront ? absoluteCenterXOffset : -absoluteCenterXOffset
                itemView.alpha = 1.0
                vc.view.layoutIfNeeded()
            }, completion: { _ in
                self.completedCallback()
            })
        }
        
        let concateneted = items + [itemView]
        adjust(itemViews: concateneted, backward: fromFront)
    }
    
    func pop(_ itemView: DequeItemView, fromFront: Bool) {
        guard let vc = viewController as? DequeViewController else { return }
        
        let items = vc.deque.items
        
        self.add { [unowned self] in
            self.startedCallback()
            UIView.animate(withDuration: 0.5, animations: {
                
                let absoluteCenterXOffset = vc.containerWidth + self.kItemWidth
                itemView.centerXConstraint?.constant = fromFront ? absoluteCenterXOffset : -absoluteCenterXOffset
                itemView.alpha = 0.0
                vc.view.layoutIfNeeded()
            }, completion: { _ in
                self.completedCallback()
            })
        }
        
        adjust(itemViews: items, backward: !fromFront)
    }
}


