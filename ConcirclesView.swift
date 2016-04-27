//
//  ConcirclesView.swift
//  electronic-structure
//
//  Created by Sarah Hinsley on 15/06/2015.
//  Copyright (c) 2015 Sarah Hinsley. All rights reserved.
//

import UIKit
import AVFoundation

class ConcirclesView: UIView {

        
    
    @IBOutlet weak var elementImage: UIImageView!
    @IBOutlet weak var cyanball1: UIImageView!
    @IBOutlet weak var cyanball2: UIImageView!
    @IBOutlet weak var cyanball3: UIImageView!
    @IBOutlet weak var cyanball4: UIImageView!
    @IBOutlet weak var cyanball5: UIImageView!
    @IBOutlet weak var cyanball6: UIImageView!
    @IBOutlet weak var cyanball7: UIImageView!
    @IBOutlet weak var cyanball8: UIImageView!
    @IBOutlet weak var cyanball9: UIImageView!
    @IBOutlet weak var cyanball10: UIImageView!
    @IBOutlet weak var cyanball11: UIImageView!
    @IBOutlet weak var cyanball12: UIImageView!
    @IBOutlet weak var cyanball13: UIImageView!
    @IBOutlet weak var cyanball14: UIImageView!
    @IBOutlet weak var cyanball15: UIImageView!
    @IBOutlet weak var cyanball16: UIImageView!
    @IBOutlet weak var cyanball17: UIImageView!
    @IBOutlet weak var cyanball18: UIImageView!
    @IBOutlet weak var cyanball19: UIImageView!
    @IBOutlet weak var cyanball20: UIImageView!
    
    @IBOutlet weak var topConstraint1: NSLayoutConstraint!
    @IBOutlet weak var leadingConstraint1: NSLayoutConstraint!
    
    var electronsArray: [UIImageView] = []
    //var shellsView: ShellsViewController!
    @IBOutlet weak var shellsView: ShellsViewController!
    
    var isElectronTooClose = false
    
    //setup electronArray (array of images, each containing an image of electrons)
        // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        /*
        // obtain context
        let ctx = UIGraphicsGetCurrentContext()
        
        // decide on radius
        let rad1 = CGRectGetWidth(rect) * 0.15
        
        let endAngle = CGFloat(2*M_PI)
        
        // add the circle to the context
        CGContextAddArc(ctx, CGRectGetMidX(rect), CGRectGetMidY(rect), rad1, 0, endAngle, 1)
        
        // set fill color
        CGContextSetFillColorWithColor(ctx,UIColor.clearColor().CGColor)
        
        // set stroke color
        CGContextSetStrokeColorWithColor(ctx,UIColor.whiteColor().CGColor)
        
        // set line width
        CGContextSetLineWidth(ctx, 4.0)
        // use to fill and stroke path (see http://stackoverflow.com/questions/13526046/cant-stroke-path-after-filling-it )
        
        // draw the path
        CGContextDrawPath(ctx, kCGPathFillStroke);
          //drawing the concentric circles
*/
        concircles(rect)
        
        
                        }
    
    func concircles(rect: CGRect) {
        
        let radiusOfShell1 = 0.15 * CGRectGetWidth(rect)
       // println("concirclesView height =  \(concirclesUIView.bounds.height)")
       // println("concirclesView origin =  \(concirclesUIView.bounds.origin.x)")
      //  println("concirclesView origin =  \(concirclesUIView.bounds.origin.y)")
        let radiusOfShell2 = 0.26 * CGRectGetWidth(rect)
        let radiusOfShell3 = 0.37 * CGRectGetWidth(rect)
        let radiusOfShell4 = 0.48 * CGRectGetWidth(rect)
        /*
        var radiusShell1Squared = (shellsizesArray[0]/2) * (shellsizesArray[0]/2)
        var radiusShell2Squared = (shellsizesArray[1]/2) * (shellsizesArray[1]/2)
        var radiusShell3Squared = (shellsizesArray[2]/2) * (shellsizesArray[2]/2)
        var radiusShell4Squared = (shellsizesArray[3]/2) * (shellsizesArray[3]/2)
        */
        let radiusShell1Squared = radiusOfShell1 * radiusOfShell1
        let radiusShell2Squared = radiusOfShell2 * radiusOfShell2
        let radiusShell3Squared = radiusOfShell3 * radiusOfShell3
        let radiusShell4Squared = radiusOfShell4 * radiusOfShell4
        radiusOfShells = [radiusOfShell1, radiusOfShell2, radiusOfShell3, radiusOfShell4]
        radiusSquared = [radiusShell1Squared, radiusShell2Squared, radiusShell3Squared, radiusShell4Squared]
        let screenBounds = self.bounds
        
        let shell1Xpos = CGRectGetMidX(screenBounds) - radiusOfShells[0]
        let shell1Ypos = CGRectGetMidY(screenBounds) - radiusOfShells[0]
        let shell2Xpos = CGRectGetMidX(screenBounds) - radiusOfShells[1]
        let shell2Ypos = CGRectGetMidY(screenBounds) - radiusOfShells[1]
        let shell3Xpos = CGRectGetMidX(screenBounds) - radiusOfShells[2]
        let shell3Ypos = CGRectGetMidY(screenBounds) - radiusOfShells[2]
        let shell4Xpos = CGRectGetMidX(screenBounds) - radiusOfShells[3]
        let shell4Ypos = CGRectGetMidY(screenBounds) - radiusOfShells[3]
        
        
   //     var shellsposArray = [[shell1Xpos, shell1Ypos],[shell2Xpos, shell2Ypos],[shell3Xpos, shell3Ypos],[shell4Xpos, shell4Ypos]]
       
        let shell1Path = UIBezierPath(ovalInRect:
            CGRect(origin: CGPoint(x: shell1Xpos, y: shell1Ypos),
                size: CGSizeMake(radiusOfShells[0] * 2, radiusOfShells[0] * 2)))
        
                let shell2Path = UIBezierPath(ovalInRect:
                    CGRect(origin: CGPoint(x: shell2Xpos, y: shell2Ypos),
                        size: CGSizeMake(radiusOfShells[1] * 2, radiusOfShells[1] * 2)))
                let shell3Path = UIBezierPath(ovalInRect:
                    CGRect(origin: CGPoint(x: shell3Xpos, y: shell3Ypos),
                        size: CGSizeMake(radiusOfShells[2] * 2, radiusOfShells[2] * 2)))
        let shell4Path = UIBezierPath(ovalInRect:
            CGRect(origin: CGPoint(x: shell4Xpos, y: shell4Ypos),
                size: CGSizeMake(radiusOfShells[3] * 2, radiusOfShells[3] * 2)))

        
        var shellPathsArray = [shell1Path, shell2Path, shell3Path, shell4Path]

        
                UIColor.whiteColor().setStroke()
        for var i = 0; i<4; i++ {
            shellPathsArray[i].lineWidth = 3.0
            shellPathsArray[i].stroke()
        }
        
            }
    /*
    func drawElectron() {
         var electron1 = UIBezierPath(ovalInRect:
            CGRect(origin: CGPoint(x: locationOfTouch.x, y: locationOfTouch.y),
                size: CGSizeMake(40, 40)))
    }
*/
    func drawElectron() {
        // Set the Center of the Circle
        // 1
        let circleCenter = locationOfTouch
        
        // Set a random Circle Radius
        // 2
        let circleWidth = CGFloat(40.0)
        let circleHeight = circleWidth
        
        // Create a new CircleView
        // 3
        let circleView = drawElectronsView(frame: CGRectMake(circleCenter.x, circleCenter.y, circleWidth, circleHeight))
        self.addSubview(circleView)
    }
    
    }
