//
//  ModalPresentationController.swift
//  modal
//
//  Created by tech-prty on 2021/03/23.
//

import UIKit

class ModalPresentationController: UIPresentationController {
 
    // 呼び出し元のView Controller の上に重ねるオーバレイView
        var overlayView = UIView()

        // 表示トランジション開始前に呼ばれる
        override func presentationTransitionWillBegin() {
            guard let containerView = containerView else {
                return
            }
            overlayView.frame = containerView.bounds
            overlayView.gestureRecognizers = [UITapGestureRecognizer(target: self, action: #selector(ModalPresentationController.overlayViewDidTouch(_:)))]
            overlayView.backgroundColor = .black
            overlayView.alpha = 0.0
            //containerView.insertSubview(overlayView, at: 0)
            print("表示トランジション開始前に呼ばれる")
            
            StackModalViewController.modalCount+=1
            (presentedViewController as! StackModalViewController).modalIndex = StackModalViewController.modalCount
            
            // トランジションを実行
            presentedViewController.transitionCoordinator?.animate(alongsideTransition: {[weak self] context in
                self?.overlayView.alpha = 0.5
                }, completion:nil)
       
        }

        // 非表示トランジション開始前に呼ばれる
        override func dismissalTransitionWillBegin() {
            presentedViewController.transitionCoordinator?.animate(alongsideTransition: {[weak self] context in
                self?.overlayView.alpha = 0.0
                }, completion:nil)
            print("非表示トランジション開始前に呼ばれる")
        }

        // 非表示トランジション開始後に呼ばれる
        override func dismissalTransitionDidEnd(_ completed: Bool) {
            if completed {
                overlayView.removeFromSuperview()
                StackModalViewController.modalCount-=1
            }
            print("非表示トランジション開始後に呼ばれる")
        }

        let margin = (x: CGFloat(0), y: CGFloat(0))
        // 子のコンテナサイズを返す
        override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
            print("子のコンテナサイズを返す")
            return CGSize(width: parentSize.width - margin.x, height: parentSize.height - margin.y)
            
        }

        // 呼び出し先のView Controllerのframeを返す
        override var frameOfPresentedViewInContainerView: CGRect {
            print("呼び出し先のView Controllerのframeを返す")
            var presentedViewFrame = CGRect()
            let containerBounds = containerView!.bounds
            let childContentSize = CGSize(width: containerBounds.width, height: containerBounds.height-50)
            presentedViewFrame.size = childContentSize
            print(presentedViewFrame)
            return presentedViewFrame
        }

        // レイアウト開始前に呼ばれる
        override func containerViewWillLayoutSubviews() {
            print("レイアウト開始前に呼ばれる")
            overlayView.frame = containerView!.bounds
            presentedView?.bounds     = frameOfPresentedViewInContainerView
            presentedView?.layer.cornerRadius = 10
            presentedView?.clipsToBounds = true
        }

        // レイアウト開始後に呼ばれる
        override func containerViewDidLayoutSubviews() {
            print("レイアウト開始後に呼ばれる")
        }

        // overlayViewをタップした時に呼ばれる
        @objc func overlayViewDidTouch(_ sender: UITapGestureRecognizer) {
            presentedViewController.dismiss(animated: true, completion: nil)
        }
}
