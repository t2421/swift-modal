//
//  AppearAnimator.swift
//  modal
//
//  Created by tech-prty on 2021/03/23.
//

import UIKit

class AppearAnimator : NSObject,UIViewControllerAnimatedTransitioning{
    var source:StackModalViewController //呼び出しもと
    var presented:StackModalViewController //呼び出し先
    
    init(from:StackModalViewController,to:StackModalViewController) {
        self.source = from
        self.presented = to
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }

    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        transitionContext.containerView.addSubview(self.presented.view!)

        self.presented.view!.alpha = 0
        self.presented.view!.frame.origin.y = 300
        
        let cubicTiming = UICubicTimingParameters(controlPoint1: CGPoint(x: 0.17, y: 0.67), controlPoint2: CGPoint(x: 0.76, y: 1.0))
        let animator = UIViewPropertyAnimator(duration: transitionDuration(using: transitionContext), timingParameters: cubicTiming)
        print("animateTransition")
       
        animator.addAnimations {
            self.presented.view.alpha = 1
            self.presented.view.frame.origin.y = 50
            self.source.view.frame.origin.y = 10
          
            if self.source.modalIndex == 0 {
                
            }else{
                self.source.view.frame.origin.y = 10
                self.source.view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                
                self.source.source?.view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }
            
          
        }
        animator.addCompletion { (position) in
            transitionContext.completeTransition(position == .end)
            print("COmp")
        }
        animator.startAnimation()
      
    }
}
