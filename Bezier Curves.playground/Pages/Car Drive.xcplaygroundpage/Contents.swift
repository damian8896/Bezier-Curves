//: [Previous](@previous)
import Foundation
import SpriteKit
import PlaygroundSupport
@_exported import UIKit

/*:
# Animation

 We will be animating the path of the car
 
 Try using bezier curves to follow the road
 
 Click add point to extend your curve
 
 Once you are done, click finish and the car will follwo your curve
 
 Isn't it awesome?
 
 This can be applied in other ways. The path of a camera. The path an enemy boss will move. The trajectory of a ball being thrown
 
 ### Thanks for playing!
 I hope you were able to learn how awesome bezier curves are
*/
let frame = CGRect(x: 0, y: 0, width: 700, height: 650)
let view = CarView(frame: frame)

PlaygroundPage.current.liveView = view
