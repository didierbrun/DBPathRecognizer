//
//  RenderView.swift
//  PathRecognizer
//
//  Created by Didier Brun on 15/03/2015.
//  Copyright (c) 2015 Didier Brun. All rights reserved.
//

import Foundation
import UIKit

class RenderView:UIView {

    var pointsToDraw:[Int] = [] {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clearColor()
    }
    
    
    override func drawRect(rect: CGRect) {
        
   
        var context = UIGraphicsGetCurrentContext();
        CGContextClearRect(context, self.bounds);
        CGContextSetLineWidth(context, 10.0);
        UIColor.redColor().set()
        
        
        if pointsToDraw.count > 4 {
            
            CGContextMoveToPoint(context, CGFloat(pointsToDraw[0]), CGFloat(pointsToDraw[1]))
            
            for i in 2..<pointsToDraw.count {
                if i % 2 == 0 {
                    CGContextAddLineToPoint(context, CGFloat(pointsToDraw[i]), CGFloat(pointsToDraw[i + 1]))
                }
            }
        }
        
        // Draw
        CGContextStrokePath(context);
    }
}
