//
//  AnimateTransitionPop.swift
//  ComplicateUI
//
//  Created by 姚宗超 on 2017/3/9.
//  Copyright © 2017年 姚宗超. All rights reserved.
//

import UIKit

class AnimateTransitionPop: NSObject {
    var originRect: CGRect?
}

extension AnimateTransitionPop: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        
        toView?.alpha = 1.0
        fromView?.alpha = 1.0
        container.addSubview(toView!)
        container.addSubview(fromView!)
        fromView?.transform = CGAffineTransform.identity
        
        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            if let rect = self.originRect {
                fromView?.transform = KDTools.createAffineTransform(fromRect: (fromView?.frame)!, toRect: rect)
            }
            fromView?.alpha = 0.0
        }) { (finished) in
            transitionContext.completeTransition(true)
        }
    }
}

extension AnimateTransitionPop: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}
