//
//  ViewController.swift
//  modal
//
//  Created by tech-prty on 2021/03/23.
//

import UIKit

class ViewController: StackModalViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tap(_ sender: Any) {
        present(HogeViewController.viewController(), animated: true, completion: nil)
    }
    
    @IBAction func tapNormal(_ sender: Any) {
        present(NormalModalViewController.viewController(), animated: true, completion: nil)
    }
}

