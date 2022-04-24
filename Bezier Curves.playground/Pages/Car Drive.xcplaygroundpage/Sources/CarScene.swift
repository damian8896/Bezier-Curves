import Foundation
import SpriteKit

public class CarScene: SKScene{
    
    let radius = 5.0
    
    var finalBezier: SKShapeNode = SKShapeNode()
    lazy var cp: [Control1DPoint] = {
        var arr = [Control1DPoint]()
        
        let cp1 = Control1DPoint(circleOfRadius: radius)
        cp1.position = CGPoint(x: 123.5, y: 493)
        
        let cp2 = Control1DPoint(circleOfRadius: radius)
        cp2.position = CGPoint(x: 127.5, y: 393.5)
        
        let cp3 = Control1DPoint(circleOfRadius: radius)
        cp3.position = CGPoint(x: 79.5, y: 245)
        
        let cp4 = Control1DPoint(circleOfRadius: radius)
        cp4.position = CGPoint(x: 307.5, y: 124)
        
        arr.append(cp1)
        arr.append(cp2)
        arr.append(cp3)
        arr.append(cp4)
        return arr
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
    
    lazy var background: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "CarBackground")
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
    
    lazy var car: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "Car")
        node.size = CGSize(width: 25, height: 50)
        node.position = CGPoint(x: 123.5, y: 493)
        return node
    }()
    
    override public func sceneDidLoad() {
        super.sceneDidLoad()
        self.addChild(background)
        self.addChild(addButton)
        self.addChild(finishButton)
        self.addChild(car)
        shapeNode.append(SKShapeNode(path: bezierCurve[0].cgPath))
        shapeNode[0].lineWidth = 4.0
        shapeNode[0].strokeColor = buttonColor
        self.addChild(shapeNode[0])
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
                
                addChild(background)
                finalCurve()
                addChild(car)
                let followTrack = SKAction.follow(finalBezier.path!, asOffset: false, orientToPath: true, speed: 100)
                car.run(followTrack)
                
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
        curve.move(to: CGPoint(x: cp[0].position.x, y: cp[0].position.y))
        for i in 0..<shapeNode.count{
            let start = i*3
            if(start + 3 < cp.count){
            curve.addCurve(to: CGPoint(x: cp[start + 3].position.x, y: cp[start + 3].position.y), controlPoint1: CGPoint(x: cp[start + 1].position.x, y: cp[start + 1].position.y), controlPoint2: CGPoint(x: cp[start + 2].position.x, y: cp[start + 2].position.y))
            }
        }
        finalBezier.path = curve.cgPath
    }
    
}


