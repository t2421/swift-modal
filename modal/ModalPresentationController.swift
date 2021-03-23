//
//  ModalPresentationController.swift
//  modal
//
//  Created by tech-prty on 2021/03/23.
//

import UIKit

class ModalPresentationController: UIPresentationController {
    private let overlayView = UIView()
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        print("presentationTransitionWillBegin")
        
        overlayView.frame = containerView!.bounds
        overlayView.backgroundColor = .black
        overlayView.alpha = 0.0
        
        //一番下にoverlayを差し込む
        containerView!.insertSubview(overlayView, at: 0)
        
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: {[unowned self] _ in
            self.overlayView.alpha = 0.5
            
        })
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        print("dismissalTransitionWillBegin")
        
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: {[unowned self] _ in
            self.overlayView.alpha = 0.0
        })
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        super.dismissalTransitionDidEnd(completed)
        print("dismissalTransitionDidEnd")
        if completed {
            overlayView.removeFromSuperview()
        }
    }
    
    override var frameOfPresentedViewInContainerView: CGRect{
        return CGRect(x: 0.0,y: 0.0,width: containerView!.bounds.width,height: containerView!.bounds.height-200.0)
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        print("containerViewWillLayoutSubviews")
        
        overlayView.frame = containerView!.bounds
        presentedView!.frame = frameOfPresentedViewInContainerView
    }
}
