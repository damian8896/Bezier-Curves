import Foundation
import SpriteKit

public class CarView: SKView{
    override public init(frame: CGRect) {
        super.init(frame: frame)
        let CarScene = CarScene(size: self.frame.size)
        self.presentScene(CarScene)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
