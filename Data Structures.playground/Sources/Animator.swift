import Foundation
import UIKit

protocol ConsequentlyAnimating {
    func add(animation: @escaping()-> Void)
    func startedCallback()
    func completedCallback()
}

class Animator: ConsequentlyAnimating {
    weak var viewController: UIViewController!

    private var animating: Bool = false
    private var animationQueue: [()-> Void] = []
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    
    fileprivate func wrapWithStarted(_ block: @escaping () -> Void) -> () -> Void {
        return {
            self.startedCallback()
            block()
        }
    }
    
    internal func add(animation: @escaping () -> Void) {
        animationQueue.append(wrapWithStarted(animation))
        if !animating {
            self.animationQueue.first?()
        }
    }
    
    internal func startedCallback() {
        self.animating = true
    }
    
    internal func completedCallback() {
        let _ = animationQueue.removeFirst()
        if animationQueue.count > 0 {
            animationQueue.first?()
        } else {
            animating = false
        }
    }
}
