//: [Previous](@previous)
import Foundation
import SpriteKit
import PlaygroundSupport
@_exported import UIKit
/*:
# Structure of Bezier Curves

Just a short recap — Bezier curves consist of a set of control points from P0 to Pn
 
 Number of Control points = n+1
 
 n is called the degree/order of the curve
 
 1 = Linear
 
 2 = Quadratic
 
 3 = Cubic
 
## In the playground
 We have 3 bezier curves - 1st, 2nd, and 3rd degree/order
 
 Let's start with linear
 
## Linear Curves
 B = (1-t)P0 + tP1
 
 The resulting "curve" is formed through linear interpolation
 
 As t increases, P1 increases influence on B while P0 decreases influence on B causing B to gradually move from P0 to P1
 
## Quadratic Curves
 Q0 = (1-t)P0 + tP1
 
 Q1 = (1-t)P1 + tP2
 
 B = (1-t)Q0 + tQ1
 
 These equations form the recursive definition of a quadratic bezier curve
 
 When combined, they give us the explicit definition
 
 B = (1-t)2P0 + 2(1-t)tP1 + t2P2
 
 As t increases, P1 increases then decreases influence, P2 increases influence, and P0 decreases influence on B
 
## Cubic Curves
 Q0 = (1-t)P0 + tP1
 
 Q1 = (1-t)P1 + tP2
 
 Q2 = (1-t)P2 + tP3
 
 R0 = (1-t)Q0 + tQ1
 
 R1 = (1-t)Q1 + tQ2
 
 B = (1-t)R0 + tR1
 
 These equations form the recursive definition of a cubic bezier curve
 
 When combined, they give us the explicit definition
 
 B = (1-t)3P0 + 3(1-t)2tP1 + 3(1-t)t2P2 + t3P3
 
 As t increases, P1 increases then decreases influence, P2 increases then decreases influence,  P3 increases influence, and P0 decreases influence on B

 As the degree of the bezier curves increase, the complexity of computing the curve increases as seen in both the explicit and recursive definition
 Hence, many programs stop at cubic and instead use Bezier splines as you did in the  [Previous](@previous) page by adding control points


## Play time...

 Again, try moving around the main ontrol points to see how the other "sub-control" points change
 
 You can also try moving the t-slider to see how linear interpolation occurs for each curve — points linearly interpolate between each other
 
## So now that we fully understand how bezier curves are created
 
 Let's see how bezier curves can be used
 [Next](@next)
*/

let frame = CGRect(x: 0, y: 0, width: 500, height: 650)
let view = StructureView(frame: frame)


PlaygroundPage.current.liveView = view

