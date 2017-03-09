//
//  AnimateTransitionPush.swift
//  ComplicateUI
//
//  Created by 姚宗超 on 2017/3/9.
//  Copyright © 2017年 姚宗超. All rights reserved.
//

import UIKit

class AnimateTransitionPush: NSObject {
    var originRect: CGRect?
}

extension AnimateTransitionPush: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        
        if let rect = self.originRect {
            toView?.transform = KDTools.createAffineTransform(fromRect: (toView?.bounds)!, toRect: rect)
        }
        
        fromView?.alpha = 1.0
        toView?.alpha = 0.0
        container.addSubview(fromView!)
        container.addSubview(toView!)
        
        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            toView?.transform = CGAffineTransform.identity
            toView?.alpha = 1.0
            fromView?.alpha = 0.0
            
        }) { (finished) in
            transitionContext.completeTransition(true)
        }
    }
}

extension AnimateTransitionPush: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}

