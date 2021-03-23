//
//  ModalViewController.swift
//  modal
//
//  Created by tech-prty on 2021/03/23.
//

import UIKit

class ModalViewController: UIViewController,DismissTransitionable,UIScrollViewDelegate {
    var percentThreshold: CGFloat = 0.3
    
    var interactor: DismissTransitioningInteractor = DismissTransitioningInteractor()
    
    var scrollOffsetY:CGFloat = 0.0
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let scrollViewGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        scrollViewGesture.delegate = self
        scrollView.addGestureRecognizer(scrollViewGesture)
        scrollView.delegate = self
        
        //引っ張って閉じるときにバウンドすると気持ち悪いので制御
        interactor.startHandler = {[weak self] in
            self?.scrollView.bounces = false
        }
        
        interactor.resetHandler = {[weak self] in
            self?.scrollView.bounces = true
        }
        print(scrollView.contentOffset)
    }
    
    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
   
        //contentOffset.yが一番上の時になぜか０にならないので、一旦の対応
        if scrollOffsetY < -48.0 {
            interactor.updateStateShouldStartIfNeeded()
        }
        interactor.setStartInteractionTranslationY(sender.translation(in: view).y)
        handleTransitionGesture(sender)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollOffsetY = scrollView.contentOffset.y
        
        
    }
    
    static func viewController() -> ModalViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "ModalViewController") as! ModalViewController
        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = viewController
                return viewController
    }
    @IBAction func tapClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}

extension ModalViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension ModalViewController : UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return ModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DissmissAnimator()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        switch interactor.state {
        case .hasStarted, .shouldFinish:
            return interactor
        case .shouldStart, .none:
            return nil
        }
    }
}
