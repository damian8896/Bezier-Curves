import Foundation
import SpriteKit

public class RollerCoasterView: SKView{
    override public init(frame: CGRect) {
        super.init(frame: frame)
        let rollerCoasterScene = RollerCoasterScene(size: self.frame.size)
        self.presentScene(rollerCoasterScene)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
