import UIKit


struct RelationsViewConstants {
    static let width: CGFloat = 80
}

class RelationsView: UIView {
    var a: CAShapeLayer?
    
    func remove(relation: Int) {
        
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            print("asd")
            self.a?.removeFromSuperlayer()
        })
        let animation:CABasicAnimation = CABasicAnimation(keyPath: "opacity")
        animation.duration = 0.1
        
        animation.fromValue = NSNumber(value: 1.0)
        animation.toValue = NSNumber(value: 0.0)

        layer.add(animation, forKey: "opacity")
        CATransaction.commit()
        print("Commited")
    }
    
    func drawLine(from start: CGPoint, to end: CGPoint) {
        let path: UIBezierPath = UIBezierPath()
        path.move(to: start)
        
        
        path.addLine(to: end)
        // Create a CAShape Layer
        let pathLayer: CAShapeLayer = CAShapeLayer()
        pathLayer.frame = bounds
        pathLayer.path = path.cgPath
        pathLayer.strokeColor = UIColor.red.cgColor
        pathLayer.fillColor = nil
        pathLayer.lineWidth = 2.0
        pathLayer.lineJoin = kCALineJoinBevel
        
        // Add layer to views layer
        layer.addSublayer(pathLayer)
        CATransaction.begin()
        
        CATransaction.setCompletionBlock({
            CATransaction.begin()
            CATransaction.setCompletionBlock({
                print("asd")
                self.a?.removeFromSuperlayer()
            })
            let animation:CABasicAnimation = CABasicAnimation(keyPath: "opacity")
            animation.duration = 1.0
            
            animation.fromValue = NSNumber(value: 1.0)
            animation.toValue = NSNumber(value: 0.0)
            
            self.a?.add(animation, forKey: "opacity")
            CATransaction.commit()
            print("Commited")
        })
        
        // Basic Animation
        let pathAnimation: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.duration = 1.0
        pathAnimation.fromValue = NSNumber(value: 0.0)
        pathAnimation.toValue = NSNumber(value:1.0)
        // Add Animation
        pathLayer.add(pathAnimation, forKey: "strokeEnd")
        print("here")
        a = pathLayer
        CATransaction.commit()

    }
}

