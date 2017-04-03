import UIKit

class QueueContainerView: UIView {
    private let thickness: CGFloat
    
    lazy var path: UIBezierPath = self.setupBezierPath()
    
    init(frame: CGRect, thickness: CGFloat) {
        self.thickness = thickness
        super.init(frame: frame)
        self.isOpaque = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        UIColor.clear.setFill()
        context.fill(rect)
        #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1).setFill()
        path.fill()
    }
    
    private func setupBezierPath() -> UIBezierPath {
        let height = self.frame.height
        let width = self.frame.width
        let thickness = self.thickness
        let radius = thickness / 2
        
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: thickness, y: 0))
        path.addLine(to: CGPoint(x: width - radius, y: 0))
        path.addArc(withCenter: CGPoint(x: width - radius, y: radius),
                    radius: radius,
                    startAngle: -CGFloat.pi / 2,
                    endAngle: CGFloat.pi / 2,
                    clockwise: true)
        path.addLine(to: CGPoint(x: radius, y: thickness))
        path.addArc(withCenter: CGPoint(x: radius, y: radius),
                    radius: radius,
                    startAngle: CGFloat.pi / 2,
                    endAngle: -CGFloat.pi / 2,
                    clockwise: true)
        

        path.move(to: CGPoint(x: 0, y: height - thickness))
        path.addLine(to: CGPoint(x: width - radius, y: height - thickness))
        path.addArc(withCenter: CGPoint(x: width - radius, y: height - radius),
                    radius: radius,
                    startAngle: -CGFloat.pi / 2,
                    endAngle: CGFloat.pi / 2,
                    clockwise: true)
        path.addLine(to: CGPoint(x: radius, y: height))
        path.addArc(withCenter: CGPoint(x: radius, y: height - radius),
                    radius: radius,
                    startAngle: CGFloat.pi / 2,
                    endAngle: -CGFloat.pi / 2,
                    clockwise: true)
        path.close()
        return path
    }
}
