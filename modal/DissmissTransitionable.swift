//
//  DissmissInteractor.swift
//  modal
//
//  Created by tech-prty on 2021/03/23.
//

import UIKit

protocol DismissTransitionable where Self: UIViewController {
    var percentThreshold: CGFloat { get }
    var interactor: DismissTransitioningInteractor { get }
}

extension DismissTransitionable {
    var shoudFinishVelocityY:CGFloat {
        return 1200
    }
}

extension DismissTransitionable {
    func handleTransitionGesture(_ sender: UIPanGestureRecognizer) {

        switch interactor.state {
        case .shouldStart:
            interactor.state = .hasStarted
            dismiss(animated: true, completion: nil)
        case .hasStarted, .shouldFinish:
            break
        case .none:
            return
        }
        print(interactor.state)
        let translation = sender.translation(in: view)
        
        //interaction可能になった時からどれくらい動かしたかを基準にpercentageを算出する
        let verticalMovement = (translation.y - interactor.startInteractionTranslationY) / view.bounds.height
        let downwardMovement = fmaxf(Float(verticalMovement), 0.0)
        let downwardMovementPercent = fminf(downwardMovement, 1.0)
        let progress = CGFloat(downwardMovementPercent)

        switch sender.state {
        case .changed:
            if progress > percentThreshold || sender.velocity(in: view).y > shoudFinishVelocityY {
                interactor.state =  .shouldFinish
            } else {
                interactor.state =  .hasStarted
            }
            interactor.update(progress)
        case .cancelled:
            interactor.cancel()
            interactor.reset()
        case .ended:
            switch interactor.state {
            case .shouldFinish:
                interactor.finish()
            case .hasStarted, .none, .shouldStart:
                interactor.cancel()
            }
            interactor.reset()
        default:
            break
        }
        print("Interactor State: \(interactor.state)")
    }
}
