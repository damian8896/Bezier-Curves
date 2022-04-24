import Foundation
import SpriteKit

public class DrawingView: SKView{
    override public init(frame: CGRect) {
        super.init(frame: frame)
        let drawingScene = DrawingScene(size: self.frame.size)
        self.presentScene(drawingScene)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
