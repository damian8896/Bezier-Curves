//: [Previous](@previous)

import Foundation
import SpriteKit
import PlaygroundSupport
@_exported import UIKit

/*:
# Uses of Bezier Curves

 What is the point of Bezier Curves?
 
 Good Question
 
 ## Here are some uses of bezier curves:
 
 ### Computer graphics
 Programs - Adobe Illustrator
 Many games utilize bezier curves to create digital objects people, castles, roads
 
 ### Animation
 Curves can be used to outline movement
 Path of an object can move along a bezier curve path
 Control ease-in vs ease-out in CSS, JavaScript
 
 ### Fonts
 True Type fonts use quadratic Bézier curves
 True Type - fonts that are universally used (all softwares use these fonts)
 
 Today we will use bezier curves for graphics and animation


## Drawing time...

 In the program, try to trace the cool Apple logo with straight lines first
 
 Then, try using bezier curves
 
 After trying both out, click finish
 
 If you tried your best to trace both correctly, the Apple logo traced with bezier curves was most likely more accurate and easier to trace
 
 When creating unique, curved shapes, it is easier to use bezier curves rather than straight lines + circles
 
## What are some other uses of bezier curves
 
 [Next](@next)
*/
let frame = CGRect(x: 0, y: 0, width: 700, height: 650)
let view = DrawingView(frame: frame)


PlaygroundPage.current.liveView = view
//: [Next](@next)
