//
//  ModalViewController.swift
//  modal
//
//  Created by tech-prty on 2021/03/23.
//

import UIKit

class StackModalViewController: UIViewController,DismissTransitionable,UIScrollViewDelegate {
    var percentThreshold: CGFloat = 0.3
    
    var interactor: DismissTransitioningInteractor = DismissTransitioningInteractor()
    var source : StackModalViewController?
    var presented : StackModalViewController?
  
    var tmpRect:CGRect?
    var modalIndex = 0
    static var modalCount = 0
    
   
 
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }
    
    
    
 
    @IBAction func tapClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}


extension StackModalViewController : UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return ModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        print("animationController for Dismiss")
        if interactor.state == .hasStarted{
            return DissmissInteractableAnimator(from: self.source!,to: self.presented!)
        }
        return DissmissAnimator(from: self.source!,to: self.presented!)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.source = source as! StackModalViewController
        self.presented = presented as! StackModalViewController
        return AppearAnimator(from: self.source!,to: self.presented!)
 
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
