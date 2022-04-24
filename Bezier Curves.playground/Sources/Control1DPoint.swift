import Foundation
import SpriteKit

public class Control1DPoint: SKShapeNode{
    
    override init(){
        super.init()
        self.fillColor = UIColor(red: 1/255.0, green: 122/255.0, blue: 254/255.0, alpha: 1.0)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

