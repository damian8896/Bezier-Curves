import Foundation
import SpriteKit

public class StructureScene: SKScene{
    
    let buttonColor: UIColor = UIColor(red: 239/255.0, green: 84/255.0, blue: 42/255.0, alpha: 1.0)
    let radius = 5.0
    
    
    
    lazy var t: UISlider = {
        let slider = UISlider(frame: CGRect(x: self.frame.maxX - 210, y: 100, width: 175, height: 5))
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.setValue(0.5, animated: true)
        slider.isContinuous = true
        slider.tintColor = buttonColor
        slider.thumbTintColor = buttonColor
        slider.addTarget(self, action: #selector(self.sliderValueDidChange), for: .valueChanged)
        return slider
    }()
    
    lazy var tlabel: SKLabelNode = {
        let label = SKLabelNode(text: "t = 0.50")
        label.position = CGPoint(x: self.frame.maxX - 125, y: 575)
        label.fontSize = 20
        label.horizontalAlignmentMode = .center
        label.fontColor = .white
        label.fontName = "HelveticaNeue-Bold"
        return label
    }()
    
    lazy var title: SKLabelNode = {
        let label: SKLabelNode = SKLabelNode(text: "Structure of \nBezier Curves")
        label.fontSize = 28.0
        label.fontColor = .white
        label.fontName = "HelveticaNeue-Bold"
        label.numberOfLines = 2
        label.position = CGPoint(x: 50, y: self.frame.maxY - 100)
        label.horizontalAlignmentMode = .left
        return label
    }()
    
    //cubic
    lazy var cubicCp: [Control1DPoint] = {
        var arr = [Control1DPoint]()
        
        let cp1 = Control1DPoint(circleOfRadius: radius)
        cp1.position = CGPoint(x: 30, y: 130)
        
        let cp2 = Control1DPoint(circleOfRadius: radius)
        cp2.position = CGPoint(x: 80, y: 40)
        
        let cp3 = Control1DPoint(circleOfRadius: radius)
        cp3.position = CGPoint(x: 210, y: 150)
        
        let cp4 = Control1DPoint(circleOfRadius: radius)
        cp4.position = CGPoint(x: 280, y: 120)
        
        arr.append(cp1)
        arr.append(cp2)
        arr.append(cp3)
        arr.append(cp4)
        return arr
    }()
    
    lazy var cubicLabel: SKSpriteNode = {
        let node = SKSpriteNode()
        node.position = CGPoint(x: self.frame.midX + 75, y: 180)
        var label = SKLabelNode(text: "Cubic Bezier Curve")
        label.fontColor = .black
        label.horizontalAlignmentMode = .left
        label.fontSize = 15
        label.fontName = "HelveticaNeue-Bold"
        node.addChild(label)
        label = SKLabelNode(text: "C0 = (1-t)P0 + tP1")
        label.fontColor = .systemGreen
        label.horizontalAlignmentMode = .left
        label.position.y = -25
        label.fontSize = 15
        label.fontName = "HelveticaNeue-Bold"
        node.addChild(label)
        label = SKLabelNode(text: "C1 = (1-t)P1 + tP2")
        label.fontColor = .systemGreen
        label.horizontalAlignmentMode = .left
        label.position.y = -50
        label.fontSize = 15
        label.fontName = "HelveticaNeue-Bold"
        node.addChild(label)
        label = SKLabelNode(text: "C2 = (1-t)P2 + tP3")
        label.fontColor = .systemGreen
        label.horizontalAlignmentMode = .left
        label.position.y = -75
        label.fontSize = 15
        label.fontName = "HelveticaNeue-Bold"
        node.addChild(label)
        label = SKLabelNode(text: "R0 = (1-t)C0 + tC1")
        label.fontColor = .systemBlue
        label.horizontalAlignmentMode = .left
        label.position.y = -100
        label.fontSize = 15
        label.fontName = "HelveticaNeue-Bold"
        node.addChild(label)
        label = SKLabelNode(text: "R1 = (1-t)C1 + tC2")
        label.fontColor = .systemBlue
        label.horizontalAlignmentMode = .left
        label.position.y = -125
        label.fontSize = 15
        label.fontName = "HelveticaNeue-Bold"
        node.addChild(label)
        label = SKLabelNode(text: "B = (1-t)R0 + tR1")
        label.fontColor = .systemRed
        label.horizontalAlignmentMode = .left
        label.position.y = -150
        label.fontSize = 15
        label.fontName = "HelveticaNeue-Bold"
        node.addChild(label)
        
        return node
    }()
    lazy var cubicCurve: UIBezierPath = addCurve(cp: cubicCp)
    lazy var cubicShape : SKShapeNode = SKShapeNode()
    
    lazy var cC0: Control1DPoint = {
        let point = Control1DPoint(circleOfRadius: radius)
        let tf = CGFloat(t.value)
        point.position = CGPoint(x: (1-tf) * cubicCp[0].position.x + tf * cubicCp[1].position.x,
                                 y: (1-tf) * cubicCp[0].position.y + tf * cubicCp[1].position.y)
        point.fillColor = .systemGreen
        return point
    }()
    lazy var cC1: Control1DPoint = {
        let point = Control1DPoint(circleOfRadius: radius)
        let tf = CGFloat(t.value)
        point.position = CGPoint(x: (1-tf) * cubicCp[1].position.x + tf * cubicCp[2].position.x,
                                 y: (1-tf) * cubicCp[1].position.y + tf * cubicCp[2].position.y)
        point.fillColor = .systemGreen
        return point
    }()
    lazy var cC2: Control1DPoint = {
        let point = Control1DPoint(circleOfRadius: radius)
        let tf = CGFloat(t.value)
        point.position = CGPoint(x: (1-tf) * cubicCp[2].position.x + tf * cubicCp[3].position.x,
                                 y: (1-tf) * cubicCp[2].position.y + tf * cubicCp[3].position.y)
        point.fillColor = .systemGreen
        return point
    }()
    lazy var cR0: Control1DPoint = {
        let point = Control1DPoint(circleOfRadius: radius)
        let tf = CGFloat(t.value)
        point.position = CGPoint(x: (1-tf) * cC0.position.x + tf * cC1.position.x,
                                 y: (1-tf) * cC0.position.y + tf * cC1.position.y)
        point.fillColor = .systemBlue
        return point
    }()
    lazy var cR1: Control1DPoint = {
        let point = Control1DPoint(circleOfRadius: radius)
        let tf = CGFloat(t.value)
        point.position = CGPoint(x: (1-tf) * cC1.position.x + tf * cC2.position.x,
                                 y: (1-tf) * cC1.position.y + tf * cC2.position.y)
        point.fillColor = .systemBlue
        return point
    }()
    lazy var cB: Control1DPoint = {
        let point = Control1DPoint(circleOfRadius: radius)
        let tf = CGFloat(t.value)
        point.position = CGPoint(x: (1-tf) * cR0.position.x + tf * cR1.position.x,
                                 y: (1-tf) * cR0.position.y + tf * cR1.position.y)
        point.fillColor = .systemRed
        return point
    }()
    lazy var cC0Path: UIBezierPath = updateLine(one: cC0, two: cC1)
    lazy var cC0Shape: SKShapeNode = SKShapeNode()
    lazy var cC1Path: UIBezierPath = updateLine(one: cC1, two: cC2)
    lazy var cC1Shape: SKShapeNode = SKShapeNode()
    lazy var cRPath: UIBezierPath = updateLine(one: cR0, two: cR1)
    lazy var cRShape: SKShapeNode = SKShapeNode()
    
    //quadratic
    lazy var quadCp: [Control1DPoint] = {
        var arr = [Control1DPoint]()
        
        let cp1 = Control1DPoint(circleOfRadius: radius)
        cp1.position = CGPoint(x: 30, y: 230)
        
        let cp2 = Control1DPoint(circleOfRadius: radius)
        cp2.position = CGPoint(x: 130, y: 400)
        
        let cp3 = Control1DPoint(circleOfRadius: radius)
        cp3.position = CGPoint(x: 240, y: 280)
        
        
        arr.append(cp1)
        arr.append(cp2)
        arr.append(cp3)
        return arr
    }()
    
    lazy var quadLabel: SKSpriteNode = {
        let node = SKSpriteNode()
        node.position = CGPoint(x: self.frame.midX + 75, y: 350)
        var label = SKLabelNode(text: "Quad Bezier Curve")
        label.fontColor = .black
        label.horizontalAlignmentMode = .left
        label.fontSize = 15
        label.fontName = "HelveticaNeue-Bold"
        node.addChild(label)
        label = SKLabelNode(text: "C0 = (1-t)P0 + tP1")
        label.fontColor = .systemGreen
        label.horizontalAlignmentMode = .left
        label.position.y = -25
        label.fontSize = 15
        label.fontName = "HelveticaNeue-Bold"
        node.addChild(label)
        label = SKLabelNode(text: "C1 = (1-t)P1 + tP2")
        label.fontColor = .systemGreen
        label.horizontalAlignmentMode = .left
        label.position.y = -50
        label.fontSize = 15
        label.fontName = "HelveticaNeue-Bold"
        node.addChild(label)
        label = SKLabelNode(text: "B = (1-t)C0 + tC1")
        label.fontColor = .systemRed
        label.horizontalAlignmentMode = .left
        label.position.y = -75
        label.fontSize = 15
        label.fontName = "HelveticaNeue-Bold"
        node.addChild(label)
        
        return node
    }()
    lazy var quadCurve: UIBezierPath = addCurve(cp: quadCp)
    lazy var quadShape : SKShapeNode = SKShapeNode()
    lazy var qC0: Control1DPoint = {
        let point = Control1DPoint(circleOfRadius: radius)
        let tf = CGFloat(t.value)
        point.position = CGPoint(x: (1-tf) * quadCp[0].position.x + tf * quadCp[1].position.x,
                                 y: (1-tf) * quadCp[0].position.y + tf * quadCp[1].position.y)
        point.fillColor = .systemGreen
        return point
    }()
    lazy var qC1: Control1DPoint = {
        let point = Control1DPoint(circleOfRadius: radius)
        let tf = CGFloat(t.value)
        point.position = CGPoint(x: (1-tf) * quadCp[1].position.x + tf * quadCp[2].position.x,
                                 y: (1-tf) * quadCp[1].position.y + tf * quadCp[2].position.y)
        point.fillColor = .systemGreen
        return point
    }()
    lazy var qB: Control1DPoint = {
        let point = Control1DPoint(circleOfRadius: radius)
        let tf = CGFloat(t.value)
        point.position = CGPoint(x: (1-tf) * qC0.position.x + tf * qC1.position.x,
                                 y: (1-tf) * qC0.position.y + tf * qC1.position.y)
        point.fillColor = .systemRed
        return point
    }()
    lazy var qCPath: UIBezierPath = updateLine(one: qC0, two: qC1)
    lazy var qCShape: SKShapeNode = SKShapeNode()
    
    //linear
    lazy var linearCp: [Control1DPoint] = {
        var arr = [Control1DPoint]()
        
        let cp1 = Control1DPoint(circleOfRadius: radius)
        cp1.position = CGPoint(x: 50, y: 500)
        
        let cp2 = Control1DPoint(circleOfRadius: radius)
        cp2.position = CGPoint(x: 250, y: 450)
        
        
        arr.append(cp1)
        arr.append(cp2)
        return arr
    }()
    lazy var linearLabel: SKSpriteNode = {
        let node = SKSpriteNode()
        node.position = CGPoint(x: self.frame.midX + 75, y: 475)
        var label = SKLabelNode(text: "Linear Bezier Curve")
        label.fontColor = .black
        label.horizontalAlignmentMode = .left
        label.fontSize = 15
        label.fontName = "HelveticaNeue-Bold"
        node.addChild(label)
        label = SKLabelNode(text: "B = (1-t)P0 + tP1")
        label.fontColor = .systemRed
        label.horizontalAlignmentMode = .left
        label.position.y = -25
        label.fontSize = 15
        label.fontName = "HelveticaNeue-Bold"
        node.addChild(label)
        
        return node
    }()
    
    lazy var linearCurve: UIBezierPath = addCurve(cp: linearCp)
    lazy var linearShape : SKShapeNode = SKShapeNode()
    lazy var lB: Control1DPoint = {
        let point = Control1DPoint(circleOfRadius: radius)
        let tf = CGFloat(t.value)
        point.position = CGPoint(x: (1-tf) * linearCp[0].position.x + tf * linearCp[1].position.x,
                                 y: (1-tf) * linearCp[0].position.y + tf * linearCp[1].position.y)
        point.fillColor = .systemRed
        return point
    }()
    
    var movableNode : SKNode?
    var selectedIx: Int?
    
    public override func didMove(to view: SKView){
        view.addSubview(t)
    }
    
    
    override public func sceneDidLoad() {
        super.sceneDidLoad()
        self.backgroundColor = .black
        
        self.addChild(title)
        self.addChild(tlabel)
        
        
        //cubic
        self.addChild(cubicLabel)
        cubicShape = SKShapeNode(path: cubicCurve.cgPath)
        cubicShape.lineWidth = 4.0
        cubicShape.strokeColor = buttonColor
        self.addChild(cubicShape)
        self.addChild(cC0)
        self.addChild(cC1)
        self.addChild(cC2)
        cC0Shape = SKShapeNode(path: cC0Path.cgPath)
        cC0Shape.lineWidth = 4.0
        cC0Shape.strokeColor = .systemGreen
        cC1Shape = SKShapeNode(path: cC1Path.cgPath)
        cC1Shape.lineWidth = 4.0
        cC1Shape.strokeColor = .systemGreen
        self.addChild(cC0Shape)
        self.addChild(cC1Shape)
        self.addChild(cR0)
        self.addChild(cR1)
        cRShape = SKShapeNode(path: cRPath.cgPath)
        cRShape.lineWidth = 4.0
        cRShape.strokeColor = .systemBlue
        self.addChild(cRShape)
        self.addChild(cB)
        for point in cubicCp{
            self.addChild(point)
        }
        
        //quad
        self.addChild(quadLabel)
        quadShape = SKShapeNode(path: quadCurve.cgPath)
        quadShape.lineWidth = 4.0
        quadShape.strokeColor = buttonColor
        self.addChild(quadShape)
        self.addChild(qC0)
        self.addChild(qC1)
        qCShape = SKShapeNode(path: qCPath.cgPath)
        qCShape.lineWidth = 4.0
        qCShape.strokeColor = .systemGreen
        self.addChild(qCShape)
        self.addChild(qB)
        for point in quadCp{
            self.addChild(point)
        }
        
        
        //linear
        self.addChild(linearLabel)
        linearShape = SKShapeNode(path: linearCurve.cgPath)
        linearShape.lineWidth = 4.0
        linearShape.strokeColor = buttonColor
        self.addChild(linearShape)
        self.addChild(lB)
        for point in linearCp{
            self.addChild(point)
        }
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            for ix in 0...cubicCp.count-1{
                let i = cubicCp[ix]
                if i.contains(location) {
                    movableNode = i
                    movableNode!.position = location
                    selectedIx = 3
                }
            }
            
            for ix in 0...quadCp.count-1{
                let i = quadCp[ix]
                if i.contains(location) {
                    movableNode = i
                    movableNode!.position = location
                    selectedIx = 2
                }
            }
            
            for ix in 0...linearCp.count-1{
                let i = linearCp[ix]
                if i.contains(location) {
                    movableNode = i
                    movableNode!.position = location
                    selectedIx = 1
                }
            }
            
        }
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, movableNode != nil {
            movableNode!.position = touch.location(in: self)
            if(selectedIx == 3){
                cubicCurve = addCurve(cp: cubicCp)
                cubicShape.path = cubicCurve.cgPath
            }
            if(selectedIx == 2){
                quadCurve = addCurve(cp: quadCp)
                quadShape.path = quadCurve.cgPath
            }
            if(selectedIx == 1){
                linearCurve = addCurve(cp: linearCp)
                linearShape.path = linearCurve.cgPath
            }
            updatePositions()
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, movableNode != nil {
            movableNode!.position = touch.location(in: self)
            movableNode = nil
        }
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            movableNode = nil
        }
    }
    
    private func addCurve(cp: [Control1DPoint])-> UIBezierPath{
        let curve = UIBezierPath()
        
        var i = 1
        curve.move(to: CGPoint(x: cp[0].position.x, y: cp[0].position.y))
        while i < cp.count{
            curve.addLine(to: CGPoint(x: cp[i].position.x, y: cp[i].position.y))
            i += 1
        }
        curve.move(to: CGPoint(x: cp[0].position.x, y: cp[0].position.y))
        
        if(cp.count == 4){
            curve.addCurve(to: CGPoint(x: cp[3].position.x, y: cp[3].position.y), controlPoint1: CGPoint(x: cp[1].position.x, y: cp[1].position.y), controlPoint2:
                        CGPoint(x: cp[2].position.x, y: cp[2].position.y))
        }else if(cp.count == 3){
            curve.addQuadCurve(to: CGPoint(x: cp[2].position.x, y: cp[2].position.y), controlPoint: CGPoint(x: cp[1].position.x, y: cp[1].position.y))
        }
        return curve
    }
    
    @objc func sliderValueDidChange(){
        tlabel.text = "t = " + String(format: "%.2f", t.value)
        
        updatePositions()
        //linear
    }
    
    private func updatePositions(){
        let tf = CGFloat(t.value)
        
        //linear
        lB.position = CGPoint(x: (1-tf) * linearCp[0].position.x + tf * linearCp[1].position.x,
                                 y: (1-tf) * linearCp[0].position.y + tf * linearCp[1].position.y)
        
        //quadratic
        qC0.position = CGPoint(x: (1-tf) * quadCp[0].position.x + tf * quadCp[1].position.x,
                                 y: (1-tf) * quadCp[0].position.y + tf * quadCp[1].position.y)
        qC1.position = CGPoint(x: (1-tf) * quadCp[1].position.x + tf * quadCp[2].position.x,
                                 y: (1-tf) * quadCp[1].position.y + tf * quadCp[2].position.y)
        qB.position = CGPoint(x: (1-tf) * qC0.position.x + tf * qC1.position.x,
                                 y: (1-tf) * qC0.position.y + tf * qC1.position.y)
        qCPath = updateLine(one: qC0, two: qC1)
        qCShape.path = qCPath.cgPath
        
        //cubic
        
        cC0.position = CGPoint(x: (1-tf) * cubicCp[0].position.x + tf * cubicCp[1].position.x,
                                 y: (1-tf) * cubicCp[0].position.y + tf * cubicCp[1].position.y)
        cC1.position = CGPoint(x: (1-tf) * cubicCp[1].position.x + tf * cubicCp[2].position.x,
                                 y: (1-tf) * cubicCp[1].position.y + tf * cubicCp[2].position.y)
        cC2.position = CGPoint(x: (1-tf) * cubicCp[2].position.x + tf * cubicCp[3].position.x,
                                 y: (1-tf) * cubicCp[2].position.y + tf * cubicCp[3].position.y)
        cR0.position = CGPoint(x: (1-tf) * cC0.position.x + tf * cC1.position.x,
                                 y: (1-tf) * cC0.position.y + tf * cC1.position.y)
        cR1.position = CGPoint(x: (1-tf) * cC1.position.x + tf * cC2.position.x,
                                 y: (1-tf) * cC1.position.y + tf * cC2.position.y)
        cB.position = CGPoint(x: (1-tf) * cR0.position.x + tf * cR1.position.x,
                                 y: (1-tf) * cR0.position.y + tf * cR1.position.y)
        cC0Path = updateLine(one: cC0, two: cC1)
        cC0Shape.path = cC0Path.cgPath
        cC1Path = updateLine(one: cC1, two: cC2)
        cC1Shape.path = cC1Path.cgPath
        cRPath = updateLine(one: cR0, two: cR1)
        cRShape.path = cRPath.cgPath
    }
    
    private func updateLine(one: Control1DPoint, two: Control1DPoint)-> UIBezierPath{
        let curve = UIBezierPath()
        curve.move(to: CGPoint(x: one.position.x, y: one.position.y))
        curve.addLine(to: CGPoint(x: two.position.x, y: two.position.y))
        return curve
    }
    
}


