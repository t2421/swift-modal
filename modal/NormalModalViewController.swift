//
//  NormalModalViewController.swift
//  modal
//
//  Created by tech-prty on 2021/03/23.
//

import UIKit

class NormalModalViewController: StackModalViewController {
    var interactiveTarget:UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        interactiveTarget = view
        let scrollViewGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        scrollViewGesture.delegate = self
        interactiveTarget.addGestureRecognizer(scrollViewGesture)
     
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
   
        interactor.updateStateShouldStartIfNeeded()
        interactor.setStartInteractionTranslationY(sender.translation(in: view).y)
        handleTransitionGesture(sender)
    }
    
    static func viewController() -> NormalModalViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "NormalModalViewController") as! NormalModalViewController
        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = viewController
                return viewController
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension NormalModalViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
