import UIKit

class HashTableAnimator: Animator {
    private var pathLayers: [CAShapeLayer] = []
    
    func animateInserting(_ keyItemView: KeyItemView) {
        self.add { [unowned self] in
            self.startedCallback()
            UIView.animate(withDuration: 0.7, animations: {
                keyItemView.alpha = 1.0
            }, completion: { _ in
                    self.completedCallback()
            })
        }
    }
    
    func animateInserting(_ hashItemView: HashItemView) {
        self.add { [unowned self] in
            self.startedCallback()
            UIView.animate(withDuration: 0.7, animations: {
                hashItemView.alpha = 1.0
            }, completion: { _ in
                self.completedCallback()
            })
        }
    }
    
    func animateInserting(_ valueItemView: ValueItemView) {
        self.add { [unowned self] in
            self.startedCallback()
            UIView.animate(withDuration: 0.7, animations: {
                valueItemView.alpha = 1.0
            }, completion: { _ in
                self.completedCallback()
            })
        }
    }
    
    func animateCreatingRelation(from keyItemView: KeyItemView, to hashView: HashItemView) {
        guard let vc = viewController as? HashTableViewController else { return }
        
        self.add { [unowned self] in
            self.startedCallback()
            let path: UIBezierPath = UIBezierPath()
            print(keyItemView.frame)
            print(keyItemView.frame.origin)
            print(hashView.frame)
            print(hashView.frame.origin)
            let startPoint = CGPoint(x: keyItemView.frame.origin.x + keyItemView.frame.width,
                                     y: keyItemView.frame.origin.y + keyItemView.frame.height / 2)
            let endPoint = CGPoint(x: hashView.frame.origin.x,
                                   y: hashView.frame.origin.y + hashView.frame.height / 2)
            
            path.move(to: startPoint)
            path.addLine(to: endPoint)
            
            // Create a CAShape Layer
            let pathLayer: CAShapeLayer = CAShapeLayer()
            pathLayer.frame = vc.view.bounds
            pathLayer.path = path.cgPath
            pathLayer.strokeColor = hashView.color.cgColor
            pathLayer.fillColor = nil
            pathLayer.lineWidth = 2.0
            pathLayer.lineJoin = kCALineJoinBevel
            
            // Add layer to views layer
            vc.view.layer.addSublayer(pathLayer)
            
            // Basic Animation
            CATransaction.begin()
            CATransaction.setCompletionBlock({
                self.completedCallback()
            })
            let pathAnimation: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
            pathAnimation.duration = 0.6
            pathAnimation.fromValue = NSNumber(value: 0.0)
            pathAnimation.toValue = NSNumber(value:1.0)
            // Add Animation
            pathLayer.add(pathAnimation, forKey: "strokeEnd")
            CATransaction.commit()
            
            self.pathLayers.append(pathLayer)
        }
    }
    
    func updateValue(in valueItemView: ValueItemView, with value: Character) {
        
        self.add {
            self.startedCallback()
            CATransaction.begin()
            CATransaction.setCompletionBlock {
                valueItemView.updateValue(value)
                self.completedCallback()
            }

            let shakeAnimation = CABasicAnimation(keyPath:"position")
            
            shakeAnimation.duration = 0.07
            shakeAnimation.repeatCount = 3
            shakeAnimation.autoreverses = true
            shakeAnimation.fromValue = CGPoint(x: valueItemView.center.x - 2.0,
                                              y: valueItemView.center.y)
            shakeAnimation.toValue = CGPoint(x: valueItemView.center.x + 2.0,
                                            y: valueItemView.center.y)
            valueItemView.layer.add(shakeAnimation, forKey: "position")
            CATransaction.commit()
        }
    }
    
    func clear() {
        guard let vc = viewController as? HashTableViewController else { return }
        let allKeyItems = Array(vc.table.keys)
        let allValueItems = Array(vc.table.values)
        let allHashItems = Array(vc.hashViewsDictionary.keys)
        self.add {
            self.startedCallback()
            allKeyItems.forEach { $0.removeFromSuperview() }
            allValueItems.forEach { $0.removeFromSuperview() }
            allHashItems.forEach { $0.removeFromSuperview() }
            self.pathLayers.forEach { $0.removeFromSuperlayer() }
            self.completedCallback()
        }
    }
}

