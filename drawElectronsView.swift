//
//  drawElectronsView.swift
//  electronic-structure
//
//  Created by Sarah Hinsley on 12/09/2015.
//  Copyright (c) 2015 Sarah Hinsley. All rights reserved.
//

import UIKit

class drawElectronsView: UIView {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        // Get the Graphics Context
        let context = UIGraphicsGetCurrentContext()
        
        //set the fill
        UIColor.greenColor().setFill()
        
        // Set the circle outerline-width
        CGContextSetLineWidth(context, 5.0)
        
        // Set the circle outerline-colour
        UIColor.redColor().set()
        
        // Create Circle
        CGContextAddArc(context, (frame.size.width)/2, frame.size.height/2, (frame.size.width - 10)/2, 0.0, CGFloat(M_PI * 2.0), 1)
        
        // Draw
        CGContextStrokePath(context)
        
        //fill
        
    }
    

}
