//
//  ViewController.swift
//  modal
//
//  Created by tech-prty on 2021/03/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tap(_ sender: Any) {
        present(ModalViewController.viewController(), animated: true, completion: nil)
    }
    
}

