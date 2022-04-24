//: [Previous](@previous)
import Foundation
import SpriteKit
import PlaygroundSupport
@_exported import UIKit
/*:
# Graphics (cont.)

 Next, we will use a bezier curve to create a roller coaster path
 
 Use the add point button to extend the path
 
 Once you are done creating your roller coaster path, press finish
 
 Although this is simplified, many games similarly use bezier curves to create curved objects like roller coaster paths, roads, people
 
 The roller coaster was created by me using bezier curves
 
 Let's use bezier cerves for animation [Next](@next)
*/
let frame = CGRect(x: 0, y: 0, width: 700, height: 650)
let view = RollerCoasterView(frame: frame)

PlaygroundPage.current.liveView = view
