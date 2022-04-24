import Foundation
import SpriteKit

public class IntroductionScene: SKScene{
    
    let radius = 5.0
    lazy var cp: [Control1DPoint] = {
        var arr = [Control1DPoint]()
        
        let cp1 = Control1DPoint(circleOfRadius: radius)
        cp1.position = CGPoint(x: 30, y: 30)
        
        let cp2 = Control1DPoint(circleOfRadius: radius)
        cp2.position = CGPoint(x: 80, y: 250)
        
        let cp3 = Control1DPoint(circleOfRadius: radius)
        cp3.position = CGPoint(x: 210, y: 150)
        
        let cp4 = Control1DPoint(circleOfRadius: radius)
        cp4.position = CGPoint(x: 280, y: 300)
        
        arr.append(cp1)
        arr.append(cp2)
        arr.append(cp3)
        arr.append(cp4)
        return arr
    }()
    
    let buttonColor: UIColor = UIColor(red: 239/255.0, green: 84/255.0, blue: 42/255.0, alpha: 1.0)
    
    lazy var playgroundsLogo: SKSpriteNode = {
        let image = SKSpriteNode(imageNamed: "PlaygroundsLogo")
        image.position = CGPoint(x:  self.frame.midX + 180, y: self.frame.maxY - 80)
        image.size = CGSize(width: 120, height: 120)
        return image
    }()
    
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
        let label: SKLabelNode = SKLabelNode(text: "Introduction to\nBezier Curves")
        label.fontColor = .white
        label.fontSize = 40.0
        label.fontName = "HelveticaNeue-Bold"
        label.numberOfLines = 2
        label.position = CGPoint(x: self.frame.midX - 180, y: self.frame.maxY - 130)
        label.horizontalAlignmentMode = .left
        return label
    }()
    
    lazy var descr: SKLabelNode = {
        let label: SKLabelNode = SKLabelNode(text: "Playground for learning\nthe basics of Bezier Curves")
        label.fontSize = 17
        label.fontName = "HelveticaNeue"
        label.fontColor = buttonColor
        label.numberOfLines = 2
        label.position = CGPoint(x: self.frame.midX - 180, y: self.frame.maxY - 180)
        label.horizontalAlignmentMode = .left
        return label
    }()
    
    lazy var background: SKSpriteNode = {
        let node = SKSpriteNode(imageNamed: "Background")
        node.size = frame.size
        node.position = CGPoint(x: frame.midX, y: frame.midY)
        return node
    }()
    
    override public func sceneDidLoad() {
        super.sceneDidLoad()
        self.backgroundColor = .black
        self.addChild(title)
        self.addChild(descr)
        
        self.addChild(playgroundsLogo)
        self.addChild(addButton)
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
            for ix in 0..<cp.count{
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
    
}


