//
//  KDTools.swift
//  ComplicateUI
//
//  Created by 姚宗超 on 2017/3/9.
//  Copyright © 2017年 姚宗超. All rights reserved.
//

import UIKit

class KDTools: NSObject {
    
    public static func createAffineTransform(fromRect: CGRect, toRect: CGRect) -> CGAffineTransform {
        let sx  = toRect.size.width/fromRect.size.width
        let sy  = toRect.size.height/fromRect.size.height
        
        let scale = CGAffineTransform.init(scaleX: sx, y: sy)
        
        let heightDiff = fromRect.size.height - toRect.size.height
        let widthDiff = fromRect.size.width - toRect.size.width
        
        let dx = toRect.origin.x - widthDiff / 2 - fromRect.origin.x
        let dy = toRect.origin.y - heightDiff / 2 - fromRect.origin.y
        
        let trans = CGAffineTransform.init(translationX: dx, y: dy)
        return scale.concatenating(trans)
    }

}

extension CGRect {
    var centerPt: CGPoint {
        get {
            return CGPoint.init(x: self.origin.x + self.width/2.0, y: self.origin.y + self.height/2.0)
        }
    }
}
