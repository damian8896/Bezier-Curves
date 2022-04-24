import Foundation
import SpriteKit

public class IntroductionView: SKView{
    override public init(frame: CGRect) {
        super.init(frame: frame)
        let introductionScene = IntroductionScene(size: self.frame.size)
        self.presentScene(introductionScene)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
