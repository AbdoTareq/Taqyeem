//
//  OwnerController.swift
//  Taqyeem
//
//  Created by Nourhan Hosny on 7/28/20.
//  Copyright © 2020 mazeedit. All rights reserved.
//

import UIKit

class OwnerController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    override func viewWillAppear(_ animated: Bool) {
    navigationController?.setNavigationBarHidden(false, animated: true)

    }
    @IBAction func showResturantImages(_ sender: Any) {
        
        
    }
    
    
    @IBAction func showFoodCategories(_ sender: Any) {
        
    }
    
    
    fileprivate var activeViewController: UIViewController? {
        didSet {
            removeInactiveViewController(oldValue)
            updateActiveViewController()
        }
    }
    fileprivate func removeInactiveViewController(_ inactiveViewController: UIViewController?) {
        if let inActiveVC = inactiveViewController {
            inActiveVC.willMove(toParent: nil)
            inActiveVC.view.removeFromSuperview()
            inActiveVC.removeFromParent()
        }
    }
    fileprivate func updateActiveViewController() {
        if let activeVC = activeViewController {
            addChild(activeVC)
            activeVC.automaticallyAdjustsScrollViewInsets = true
            activeVC.view.frame = containerView.bounds
            containerView.addSubview(activeVC.view)
            activeVC.didMove(toParent: self)
        }
    }
    
    
}
