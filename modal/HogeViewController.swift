//
//  HogeViewController.swift
//  modal
//
//  Created by tech-prty on 2021/03/23.
//

import UIKit

class HogeViewController: ScrollModalViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        scrollTarget = scrollView
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tap(_ sender: Any) {
        present(NormalModalViewController.viewController(), animated: true, completion: nil	)
    }
    static func viewController() -> HogeViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "ModalViewController") as! HogeViewController
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
