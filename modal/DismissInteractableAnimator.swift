//
//  DismissInteractableAnimator.swift
//  modal
//
//  Created by tech-prty on 2021/03/23.
//

import UIKit

class DissmissInteractableAnimator: NSObject,UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    var source:StackModalViewController
    var presented:StackModalViewController
    
    init(from:StackModalViewController,to:StackModalViewController) {
        
        self.source = from
        self.presented = to
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let presented = transitionContext.viewController(forKey: .from),
                    let fromView = transitionContext.view(forKey: .from) else {
                    transitionContext.completeTransition(true)
                    return
                }
       
        var fromFinalFrame = transitionContext.finalFrame(for: presented)
        let newFinalOrigin = CGPoint(x: fromFinalFrame.origin.x, y: UIScreen.main.bounds.height)
        fromFinalFrame.origin = newFinalOrigin
                
                //閉じるときはInteractiveに対応するためUIView.animateを使う
                UIView.animate(
                    withDuration: transitionDuration(using: transitionContext),
                    animations: {
                        fromView.frame = fromFinalFrame
                        fromView.alpha = 0
                        self.source.view.alpha = 1
                        self.source.view.transform = CGAffineTransform.identity
                        if self.source.modalIndex == 0 {
                            self.source.view.frame.origin.y = 0
                        }else{
                            self.source.view.frame.origin.y = 60
                        }
                    },
                    completion: { _ in
                        let success = !transitionContext.transitionWasCancelled

                        transitionContext.completeTransition(success)


                    }
                )
        
    }
}
