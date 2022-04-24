import Foundation
import SpriteKit

public class StructureView: SKView{
    override public init(frame: CGRect) {
        super.init(frame: frame)
        let structureScene = StructureScene(size: self.frame.size)
        self.presentScene(structureScene)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
