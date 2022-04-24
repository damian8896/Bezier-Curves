import Foundation
import SpriteKit
import PlaygroundSupport
@_exported import UIKit

/*:
# Bezier Curves
[Bezier Curves](https://en.wikipedia.org/wiki/RSA_(cryptosystem)) are defined as parametric curves that use Bernstein polynomials

But what is the point of Bezier Curves?

Let's start by going over the basics.
## Structure
 Bezier curves consist of a set of control points from P0 to Pn
 
 Number of Control points = n+1
 
 n is called the degree/order of the curve
 
 1 = Linear
 
 2 = Quadratic
 
 3 = Cubic
 
 We will mostly be dealing with Linear, Quadratic, and Cubic bezier curves in this program as these curves are most commonly used
 
 
## Some Brief History
 A mathematician and an engineer at two competing French car manufacturers had a problem to tackle — ,odel smooth, curvy cars to utilize gas effectively
 This was French engineer Pierre Bezier at Renault and mathematician Paul de Castelijau at Citroen. de Casteljau discovered "Bezier Curves" a few years earlier than Bezier, but Citroen did not allow him to publish his work
 
 This allowed Pierre Bezier to publish the Bezier Curve. Due to the limitations of computer technology at the time, there weren't many applications of the bezier curve. However, eventually 3 computer scientists started their own company to focus on graphics, utilizing Bezier Curves to create design products. This company was called Adobe.



## Play time...

 In the program, the control points are the **straight lines** while the bezier curve is the **curved line**
 
 Begin by **moving the control points** to see how the curve changes
 
 Then try adding more control points with the add button on the bottom right
 
 By joining bezier curves together, we create **bezier splines** which are piecewise functions of bezier curves
 
 In order to maintain the **smoothness** of your curves (no sharp turns), notice that your control points have to be **colinear** and the **same distance** from the endpoints of each curve
 
 ## Now that you've gotten the hang of bezier curves...
 
 Let's delve more into the structure of bezier curves
 [Next](@next)
*/


let frame = CGRect(x: 0, y: 0, width: 500, height: 650)
let view = IntroductionView(frame: frame)


PlaygroundPage.current.liveView = view
