import Foundation
import SpriteKit

public class DrawingScene: SKScene{
    
    let buttonColor = UIColor(red: 239/255.0, green: 84/255.0, blue: 42/255.0, alpha: 1.0)
    let radius = 2.5

    var movableNode : SKNode?
    var selectedIx: Int?
    
    lazy var cp: [Control1DPoint] = {
        var arr = [Control1DPoint]()
        
        let cp1 = Control1DPoint(circleOfRadius: radius)
        cp1.position = CGPoint(x: 494, y: 393)
        
        let cp2 = Control1DPoint(circleOfRadius: radius)
        cp2.position = CGPoint(x: 380, y: 375)
        
        let cp3 = Control1DPoint(circleOfRadius: radius)
        cp3.position = CGPoint(x: 448, y: 200)
        
        let cp4 = Control1DPoint(circleOfRadius: radius)
        cp4.position = CGPoint(x: 497, y: 197)
        
        arr.append(cp1)
        arr.append(cp2)
        arr.append(cp3)
        arr.append(cp4)
        return arr
    }()
    
    var finalBezier: SKShapeNode = SKShapeNode()
    var finalLinear: SKShapeNode = SKShapeNode()
    
    lazy var lp: [Control1DPoint] = {
        var arr = [Control1DPoint]()
            
        let lp1 = Control1DPoint(circleOfRadius: radius)
        lp1.position = CGPoint(x: 51.5, y: 300)
        
        let lp2 = Control1DPoint(circleOfRadius: radius)
        lp2.position = CGPoint(x: 109, y: 197)
        
        arr.append(lp1)
        arr.append(lp2)
        
        return arr
    }()
    
    lazy var bezierCurve: [UIBezierPath] = [addCurve(index: 0, type: "Bezier")]
    lazy var shapeNode : [SKShapeNode] = []
    
    lazy var linearCurve: [UIBezierPath] = [addCurve(index:0, type: "Linear")]
    lazy var linearNode: [SKShapeNode] = []
    
    lazy var add2Button: SKShapeNode = {
        let button = SKShapeNode(rect: CGRect(x: self.frame.maxX - 180, y: 30, width: 160, height: 50), cornerRadius: 15)
        button.fillColor = buttonColor
        button.strokeColor = buttonColor
        let label = SKLabelNode(text: "Add Point")
        label.fontName = "HelveticaNeue-Bold"
        label.fontSize = 14
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.position = CGPoint(x: button.frame.midX, y: button.frame.midY)
        button.addChild(label)
        return button
    }()
    
    lazy var add1Button: SKShapeNode = {
        let button = SKShapeNode(rect: CGRect(x: 20, y: 30, width: 160, height: 50), cornerRadius: 15)
        button.fillColor = buttonColor
        button.strokeColor = buttonColor
        let label = SKLabelNode(text: "Add Point")
        label.fontName = "HelveticaNeue-Bold"
        label.fontSize = 14
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        label.position = CGPoint(x: button.frame.midX, y: button.frame.midY)
        button.addChild(label)
        return button
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
    
    lazy var title: SKLabelNode = {
        let label: SKLabelNode = SKLabelNode(text: "Try Tracing This Cool Logo!")
        label.fontSize = 48
        label.fontColor = buttonColor
        label.fontName = "HelveticaNeue-Bold"
        label.numberOfLines = 2
        label.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 130)
        label.horizontalAlignmentMode = .center
        return label
    }()
    
    lazy var logo1: SKSpriteNode = {
        let logo = SKSpriteNode(imageNamed: "appleLogo")
        logo.position = CGPoint(x: self.frame.midX - 190, y: self.frame.midY)
        logo.size = CGSize(width: 300, height: 300)
        return logo
    }()
    
    lazy var logo2: SKSpriteNode = {
        let logo = SKSpriteNode(imageNamed: "appleLogo")
        logo.position = CGPoint(x: self.frame.midX + 190, y: self.frame.midY)
        logo.size = CGSize(width: 300, height: 300)
        return logo
    }()
    
    lazy var finalText: SKLabelNode = {
        let text = SKLabelNode(text: "Wow! The right drawing looks so much more accurate than the left drawing!")
        text.position = CGPoint(x: self.frame.midX, y: 50)
        text.horizontalAlignmentMode = .center
        text.fontSize = 15
        text.fontColor = buttonColor
        text.fontName = "HelveticaNeue-Bold"
        return text
    }()
    
    lazy var background: SKSpriteNode = {
       let background = SKSpriteNode(imageNamed: "Background")
        background.size = frame.size
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        return background
        
    }()
    
    
    
    var isBezier: Bool = false
    
    override public func sceneDidLoad() {
        super.sceneDidLoad()
        self.backgroundColor = .black
        
        self.addChild(title)
        
        self.addChild(logo1)
        self.addChild(logo2)
        self.addChild(add2Button)
        self.addChild(add1Button)
        self.addChild(finishButton)
        
        shapeNode.append(SKShapeNode(path: bezierCurve[0].cgPath))
        shapeNode[0].lineWidth = 4.0
        shapeNode[0].strokeColor = buttonColor
        self.addChild(shapeNode[0])
        
        linearNode.append(SKShapeNode(path: linearCurve[0].cgPath))
        linearNode[0].lineWidth = 4.0
        linearNode[0].strokeColor = buttonColor
        self.addChild(linearNode[0])
        
        
        for point in lp{
            self.addChild(point)
        }
        
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
                    isBezier = true
                    movableNode = i
                    movableNode!.position = location
                    selectedIx = ix
                }
            }
            
            for ix in 0..<lp.count{
                let i = lp[ix]
                if i.contains(location) {
                    isBezier = false
                    movableNode = i
                    movableNode!.position = location
                    selectedIx = ix
                }
            }
            
            if add2Button.contains(location){
                add2Button.fillColor = UIColor(red: 40/255.0, green: 163/255.0, blue: 255/255.0, alpha: 1.0)
                let point = Control1DPoint(circleOfRadius: radius)
                point.position = CGPoint(x: cp[cp.count-1].position.x + 20, y: cp[cp.count-1].position.y + 20)
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
                    bezierCurve.append(addCurve(index: index, type: "Bezier"))
                    shapeNode.append(SKShapeNode(path: bezierCurve[bezierCurve.count - 1].cgPath))
                    shapeNode[shapeNode.count-1].lineWidth = 4.0
                    shapeNode[shapeNode.count-1].strokeColor = buttonColor
                    addChild(shapeNode[shapeNode.count-1])
                }else{
                    addPoint(index: index, type: "Bezier")
                }
                self.addChild(point)
            }
            
            if add1Button.contains(location){
                add1Button.fillColor = UIColor(red: 40/255.0, green: 163/255.0, blue: 255/255.0, alpha: 1.0)
                let point = Control1DPoint(circleOfRadius: radius)
                point.position = CGPoint(x: lp[lp.count-1].position.x + 20, y: lp[lp.count-1].position.y + 20)
                point.fillColor = .systemRed
                lp[lp.count-1].fillColor = UIColor(red: 1/255.0, green: 122/255.0, blue: 254/255.0, alpha: 1.0)
                if point.position.x > frame.maxX{
                    point.position.x = frame.maxX - 50
                }
                if point.position.y > frame.maxY{
                    point.position.y = frame.maxY - 50
                }
                lp.append(point)
                
                linearCurve.append(addCurve(index: lp.count-2, type: "Linear"))
                linearNode.append(SKShapeNode(path: linearCurve[linearCurve.count - 1].cgPath))
                linearNode[linearNode.count-1].lineWidth = 4.0
                linearNode[linearNode.count-1].strokeColor = buttonColor
                addChild(linearNode[linearNode.count-1])
                self.addChild(point)
            }
            
            if(finishButton.contains(location)){
                self.removeAllChildren()
                addChild(title)
                finalCurve()
                addChild(finalLinear)
                addChild(finalBezier)
                addChild(finalText)
            }
        }
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, movableNode != nil {
            movableNode!.position = touch.location(in: self)
            if(isBezier){
                addPoint(index: selectedIx!, type: "Bezier")
            }else{
                addPoint(index: selectedIx!, type: "Linear")
            }
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, movableNode != nil {
            movableNode!.position = touch.location(in: self)
            movableNode = nil
        }
        add2Button.fillColor = buttonColor
        add1Button.fillColor = buttonColor
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            movableNode = nil
        }
    }
    
    private func addPoint(index: Int, type: String){
        if(type == "Bezier"){
            let ix = index / 3
            if(index % 3 == 0 && index != 0){
                bezierCurve[ix-1] = addCurve(index: index-3, type: "Bezier")
                shapeNode[ix-1].path = bezierCurve[ix-1].cgPath
            }
            if(!(index % 3 == 0 && index == cp.count-1)){
                bezierCurve[ix] = addCurve(index: index, type: "Bezier")
                shapeNode[ix].path = bezierCurve[ix].cgPath
            }
        }else{
            if(index - 1 > -1){
                linearCurve[index-1] = addCurve(index: index-1, type: "Linear")
                linearNode[index-1].path = linearCurve[index-1].cgPath
            }
            if(index + 1 < lp.count){
                linearCurve[index] = addCurve(index: index, type: "Linear")
                linearNode[index].path = linearCurve[index].cgPath
            }
        }
    }
    
    private func addCurve(index: Int, type: String)-> UIBezierPath{
        if(type == "Bezier"){
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
        }else{
            let curve = UIBezierPath()
            curve.move(to: CGPoint(x: lp[index].position.x, y: lp[index].position.y))
            curve.addLine(to: CGPoint(x: lp[index + 1].position.x, y: lp[index + 1].position.y))
            return curve
        }
    }
    
    private func finalCurve(){
        var curve = UIBezierPath()
        curve.move(to: CGPoint(x: cp[0].position.x, y: cp[0].position.y))
        for i in 0..<shapeNode.count{
            let start = i*3
            if(start + 3 < cp.count){
            curve.addCurve(to: CGPoint(x: cp[start + 3].position.x, y: cp[start + 3].position.y), controlPoint1: CGPoint(x: cp[start + 1].position.x, y: cp[start + 1].position.y), controlPoint2: CGPoint(x: cp[start + 2].position.x, y: cp[start + 2].position.y))
            }
        }
        curve.addLine(to: CGPoint(x: cp[0].position.x, y: cp[0].position.y))
        finalBezier.path = curve.cgPath
        finalBezier.strokeColor = buttonColor
        finalBezier.fillColor = buttonColor
        
        curve = UIBezierPath()
        curve.move(to: CGPoint(x: lp[0].position.x, y: lp[0].position.y))
        for i in 1..<lp.count{
            curve.addLine(to: CGPoint(x: lp[i].position.x, y: lp[i].position.y))
        }
        curve.addLine(to: CGPoint(x: lp[0].position.x, y: lp[0].position.y))
        finalLinear.path = curve.cgPath
        finalLinear.strokeColor = buttonColor
        finalLinear.fillColor = buttonColor
    }
    
}


