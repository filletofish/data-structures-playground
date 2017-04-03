import UIKit

class StackAnimator: Animator {
    
    func push(_ itemView: StackItemView) {
        guard let vc = viewController as? StackViewController else { return }
        
        let restCount = vc.maxStackSize - vc.stack.items.count
        self.add { [unowned self] in
            UIView.animate(withDuration: 2.0, animations: {
                let constant = CGFloat(restCount) * (vc.kItemHeight + vc.kItemSpacing) - vc.kFirstItemOffset
                itemView.bottomConstraint?.constant = constant
                itemView.alpha = 1.0
                vc.view.layoutIfNeeded()
            }, completion: { _ in
                self.completedCallback()
            })
        }
    }
    
    func pop(_ itemView: StackItemView) {
        guard let vc = viewController as? StackViewController else { return }
        
        self.add { [unowned self] in
            
            UIView.animate(withDuration: 2.0, animations: {
                itemView.bottomConstraint?.constant = 0
                vc.view.layoutIfNeeded()
            }, completion: { _ in
                self.completedCallback()
            })
        }
        
        self.add { [unowned self] in
            let currentDirection = CGFloat(randomDirection())

            UIView.animate(withDuration: 0.7, delay: 0.0, options: [.curveEaseOut], animations: {
                let itemHeight = itemView.frame.height
                
                itemView.bottomConstraint?.constant -= itemHeight
                itemView.alignXConstraint?.constant += itemHeight * currentDirection
                itemView.alpha = 0.0
                itemView.transform = CGAffineTransform(rotationAngle: 45 * currentDirection)
                vc.view.layoutIfNeeded()
            }, completion: { _ in
                itemView.removeFromSuperview()
                self.completedCallback()
            })
        }
    }
}
