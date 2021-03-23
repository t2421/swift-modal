//
//  DismissInterctor.swift
//  modal
//
//  Created by tech-prty on 2021/03/23.
//

import UIKit

class DismissTransitioningInteractor: UIPercentDrivenInteractiveTransition {
    enum State {
        case none
        case shouldStart //interaction可能になった最初のフレームだけ呼び出すためのフラグ
        case hasStarted //shoudStartを経てinteractionしている途中
        case shouldFinish
    }

    var state: State = .none

    var startInteractionTranslationY: CGFloat = 0

    var startHandler: (() -> Void)?

    var resetHandler: (() -> Void)?
    
    override func cancel() {
        completionSpeed = percentComplete
        super.cancel()
    }
    
    override func finish() {
        completionSpeed = 1.0 - percentComplete
        super.finish()
    }
    
    func setStartInteractionTranslationY(_ translationY: CGFloat) {
        switch state {
        case .shouldStart:
            //interaction可能になった時の値をセットしておく
            startInteractionTranslationY = translationY
        case .hasStarted, .shouldFinish, .none:
            break
        }
    }

    func updateStateShouldStartIfNeeded() {
        switch state {
        case .none:
            state = .shouldStart
            startHandler?()
        case .shouldStart, .hasStarted, .shouldFinish:
            break
        }
    }

    func reset() {
        state = .none
        startInteractionTranslationY = 0
        resetHandler?()
    }
}
