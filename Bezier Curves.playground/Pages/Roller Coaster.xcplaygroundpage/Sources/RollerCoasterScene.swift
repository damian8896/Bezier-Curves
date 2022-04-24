import Foundation
import SpriteKit

public class RollerCoasterScene: SKScene{
    
    let radius = 5.0
    
    
    lazy var sp0: Control1DPoint = {
        let point = Control1DPoint(circleOfRadius: radius)
        point.position = CGPoint(x: 36, y: 400)
        return point
    }()
    
    lazy var sp1: Control1DPoint = {
        let point = Control1DPoint(circleOfRadius: radius)
        point.position = CGPoint(x: 125, y: 400)
        return point
    }()
    
    var finalBezier: SKShapeNode = SKShapeNode()
    lazy var cp: [Control1DPoint] = {
        var arr = [Control1DPoint]()
        
        let cp1 = Control1DPoint(circleOfRadius: radius)
        cp1.position = CGPoint(x: sp1.position.x, y: sp1.position.y)
        
        let cp2 = Control1DPoint(circleOfRadius: radius)
        cp2.position = CGPoint(x: 280, y: 400)
        
        let cp3 = Control1DPoint(circleOfRadius: radius)
        cp3.position = CGPoint(x: 200, y: 300)
        
        let cp4 = Control1DPoint(circleOfRadius: radius)
        cp4.position = CGPoint(x: 330, y: 220)
        
        arr.append(cp1)
        arr.append(cp2)
        arr.append(cp3)
        arr.append(cp4)
        return arr
    }()
    
    lazy var startLine: SKShapeNode = {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: sp0.position.x, y: sp0.position.y))
        path.addLine(to: CGPoint(x: sp1.position.x, y: sp1.position.y))
        
        let node = SKShapeNode(path: path.cgPath)
        node.lineWidth = 4.0
        node.strokeColor = buttonColor
        return node
    }()
    
    let buttonColor: UIColor = UIColor(red: 239/255.0, green: 84/255.0, blue: 42/255.0, alpha: 1.0)
    
    var movableNode : SKNode?
    lazy var bezierCurve: [UIBezierPath] = [addCurve(index: 0)]
    lazy var shapeNode : [SKShapeNode] = []
    lazy var addButton: SKShapeNode = {
        let button = SKShapeNode(rect: CGRect(x: self.frame.maxX - 170, y: 30, width: 160, height: 50), cornerRadius: 15)
        button.fillColor = buttonColor
        button.strokeColor = buttonColor
        let label = SKLabelNode(text: "Add Point")
        label.fontName = "HelveticaNeue-Bold"
        label.fontSize = 14
        label.fontColor = .white
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.position = CGPoint(x: button.frame.midX, y: button.frame.midY)
        button.addChild(label)
        return button
    }()
    var selectedIx: Int?
    
    lazy var title: SKLabelNode = {
        let label: SKLabelNode = SKLabelNode(text: "Try Building a Roller Coaster")
        label.fontColor = .white
        label.fontSize = 40.0
        label.fontName = "HelveticaNeue-Bold"
        label.numberOfLines = 2
        label.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 130)
        label.horizontalAlignmentMode = .center
        return label
    }()
    
    lazy var background: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "RollerCoasterBackground")
        node.size = frame.size
        node.position = CGPoint(x: frame.midX, y: frame.midY)
        return node
    }()
    
    lazy var finishButton: SKShapeNode = {
        let button = SKShapeNode(rect: CGRect(x: self.frame.midX - 80, y: 30, width: 160, height: 50), cornerRadius: 15)
        button.fillColor = buttonColor
        button.strokeColor = buttonColor
        let label = SKLabelNode(text: "Finish")
        label.fontName = "HelveticaNeue-Bold"
        label.fontSize = 14
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.position = CGPoint(x: button.frame.midX, y: button.frame.midY)
        button.addChild(label)
        return button
    }()
    
    lazy var rollerCoaster: SKSpriteNode = {
        let sprite = SKSpriteNode(imageNamed: "RollerCoaster")
        sprite.position = CGPoint(x: 75, y: 412)
        sprite.size = CGSize(width: 50, height: 18)
        sprite.physicsBody = SKPhysicsBody(texture: (sprite.texture)!, size: sprite.texture!.size())
        sprite.physicsBody?.isDynamic = false
        return sprite
    }()
    
    public override func didMove(to view: SKView) {
        view.showsPhysics = true
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        addChild(rollerCoaster)
    }
    
    override public func sceneDidLoad() {
        super.sceneDidLoad()
        self.addChild(background)
        
        
        self.addChild(title)
        self.addChild(addButton)
        self.addChild(finishButton)
        shapeNode.append(SKShapeNode(path: bezierCurve[0].cgPath))
        shapeNode[0].lineWidth = 4.0
        shapeNode[0].strokeColor = buttonColor
        self.addChild(shapeNode[0])
        self.addChild(startLine)
        for point in cp{
            self.addChild(point)
        }
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            for ix in 1..<cp.count{
                let i = cp[ix]
                if i.contains(location) {
                    movableNode = i
                    movableNode!.position = location
                    selectedIx = ix
                }
            }
            
            if addButton.contains(location){
                addButton.fillColor = UIColor(red: 40/255.0, green: 163/255.0, blue: 255/255.0, alpha: 1.0)
                let point = Control1DPoint(circleOfRadius: radius)
                point.position = CGPoint(x: cp[cp.count-1].position.x + 100, y: cp[cp.count-1].position.y + 100)
                point.fillColor = .systemRed
                cp[cp.count-1].fillColor = UIColor(red: 1/255.0, green: 122/255.0, blue: 254/255.0, alpha: 1.0)
                if point.position.x > frame.maxX{
                    point.position.x = frame.maxX - 50
                }
                if point.position.y > frame.maxY{
                    point.position.y = frame.maxY - 50
                }
                cp.append(point)
                let index = cp.count-1
                if(index % 3 == 1){
                    bezierCurve.append(addCurve(index: index))
                    shapeNode.append(SKShapeNode(path: bezierCurve[bezierCurve.count - 1].cgPath))
                    shapeNode[shapeNode.count-1].lineWidth = 4.0
                    shapeNode[shapeNode.count-1].strokeColor = buttonColor
                    addChild(shapeNode[shapeNode.count-1])
                }else{
                    addPoint(index: index)
                }
                self.addChild(point)
            }
            
            if(finishButton.contains(location)){
                self.removeAllChildren()
                self.physicsBody?.friction = 0
                
                addChild(background)
                addChild(title)
                finalCurve()
                addChild(finalBezier)
                
                addChild(rollerCoaster)
                rollerCoaster.physicsBody?.isDynamic = true
                rollerCoaster.physicsBody?.allowsRotation = true
                rollerCoaster.physicsBody?.applyForce(CGVector(dx: 500, dy: 0))
            }
        }
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, movableNode != nil {
            movableNode!.position = touch.location(in: self)
            addPoint(index: selectedIx!)
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, movableNode != nil {
            movableNode!.position = touch.location(in: self)
            movableNode = nil
        }
        addButton.fillColor = buttonColor
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            movableNode = nil
        }
    }
    
    private func addPoint(index: Int){
        let ix = index / 3
        if(index % 3 == 0 && index != 0){
            bezierCurve[ix-1] = addCurve(index: index-3)
            shapeNode[ix-1].path = bezierCurve[ix-1].cgPath
        }
        if(!(index % 3 == 0 && index == cp.count-1)){
            bezierCurve[ix] = addCurve(index: index)
            shapeNode[ix].path = bezierCurve[ix].cgPath
        }
    }
    
    private func addCurve(index: Int)-> UIBezierPath{
        var start = index
        start -= index % 3
        let curve = UIBezierPath()
        
        var i = 1
        curve.move(to: CGPoint(x: cp[start].position.x, y: cp[start].position.y))
        while start+i < cp.count && i < 4{
            if(i != 2){
                curve.addLine(to: CGPoint(x: cp[start + i].position.x, y: cp[start + i].position.y))
            }else{
                curve.move(to: CGPoint(x: cp[start+i].position.x, y: cp[start+i].position.y))
            }
            i += 1
        }
        
        if(i == 4){
            curve.move(to: CGPoint(x: cp[start].position.x, y: cp[start].position.y))
            curve.addCurve(to: CGPoint(x: cp[start + 3].position.x, y: cp[start + 3].position.y), controlPoint1: CGPoint(x: cp[start + 1].position.x, y: cp[start + 1].position.y), controlPoint2: CGPoint(x: cp[start + 2].position.x, y: cp[start + 2].position.y))
        }
        return curve
    }
    
    private func finalCurve(){
        let curve = UIBezierPath()
        var convexHall = [SKPhysicsBody]()
        curve.move(to: CGPoint(x: sp0.position.x, y: sp0.position.y))
        curve.addLine(to: CGPoint(x: sp1.position.x, y: sp1.position.y))
        
        convexHall.append(SKPhysicsBody(edgeFrom: CGPoint(x: sp0.position.x, y: sp0.position.y), to: CGPoint(x: sp1.position.x, y: sp1.position.y)))
        let points = 8
        
        for i in 0..<shapeNode.count{
            let start = i*3
            if(start + 3 < cp.count){
                let x0 = cp[start].position.x
                let y0 = cp[start].position.y
                let x1 = cp[start + 1].position.x
                let y1 = cp[start + 1].position.y
                let x2 = cp[start + 2].position.x
                let y2 = cp[start + 2].position.y
                let x3 = cp[start + 3].position.x
                let y3 = cp[start + 3].position.y
                curve.addCurve(to: CGPoint(x: cp[start + 3].position.x, y: cp[start + 3].position.y), controlPoint1: CGPoint(x: cp[start + 1].position.x, y: cp[start + 1].position.y), controlPoint2: CGPoint(x: cp[start + 2].position.x, y: cp[start + 2].position.y))
                for j in 1..<points+1{
                    let t:Double = 1.0 / Double(points) * Double(j)
                    let t0:Double = 1.0 / Double(points) * Double(j-1)
                    
                    
                    let x = (1-t) * (1-t) * (1-t) * x0 + 3 * (1-t) * (1-t) * t * x1 + 3 * (1-t) * t * t * x2 + t * t * t * x3
                    let y = (1-t) * (1-t) * (1-t) * y0 + 3 * (1-t) * (1-t) * t * y1 + 3 * (1-t) * t * t * y2 + t * t * t * y3
                    
                    
                    let xint = (1-t0) * (1-t0) * (1-t0) * x0 + 3 * (1-t0) * (1-t0) * t0 * x1 + 3 * (1-t0) * t0 * t0 * x2 + t0 * t0 * t0 * x3
                    let yint = (1-t0) * (1-t0) * (1-t0) * y0 + 3 * (1-t0) * (1-t0) * t0 * y1 + 3 * (1-t0) * t0 * t0 * y2 + t0 * t0 * t0 * y3
                    
                    convexHall.append(SKPhysicsBody(edgeFrom: CGPoint(x: xint, y: yint), to: CGPoint(x: x, y: y)))
                }
            }
        }
        finalBezier.path = curve.cgPath
        finalBezier.strokeColor = buttonColor
        finalBezier.lineWidth = 6
        finalBezier.physicsBody = SKPhysicsBody(bodies: convexHall)
        finalBezier.physicsBody?.isDynamic = false
    }
    
}


