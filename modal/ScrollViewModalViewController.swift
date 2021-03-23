//
//  ScrollViewModalViewController.swift
//  modal
//
//  Created by tech-prty on 2021/03/23.
//

import UIKit

class ScrollModalViewController: StackModalViewController {
    
  
    var scrollOffsetY:CGFloat = 0.0
    var scrollTarget: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scrollViewGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        scrollViewGesture.delegate = self
        scrollTarget.addGestureRecognizer(scrollViewGesture)
        scrollTarget.delegate = self
        
        //引っ張って閉じるときにバウンドすると気持ち悪いので制御
        interactor.startHandler = {[weak self] in
            self?.scrollTarget.bounces = false
        }
        
        interactor.resetHandler = {[weak self] in
            self?.scrollTarget.bounces = true
        }
      
        // Do any additional setup after loading the view.
    }
    
 
    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
   
        //contentOffset.yが一番上の時になぜか０にならないので、一旦の対応??
        if scrollOffsetY < 0{
            interactor.updateStateShouldStartIfNeeded()
        }
        interactor.setStartInteractionTranslationY(sender.translation(in: view).y)
        handleTransitionGesture(sender)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollOffsetY = scrollView.contentOffset.y
        print(scrollOffsetY)
        
        
    }

}
extension ScrollModalViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
