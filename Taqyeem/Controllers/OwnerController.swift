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
    
    @IBOutlet weak var imagesView: UIView!
    @IBOutlet weak var categoryView: UIView!
    var resturantFoodCategories : ResturantFoodCategoriesVC!
    var resturantimagesVc : ResturantImagesVC!
    var resturant : ResturantVM!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.resturantFoodCategories  = self.storyboard?.instantiateViewController(withIdentifier: "ResturantFoodCategoriesVC") as? ResturantFoodCategoriesVC
         self.resturantimagesVc  = self.storyboard?.instantiateViewController(withIdentifier: "ResturantImagesVC") as? ResturantImagesVC
          self.activeViewController =  self.resturantFoodCategories
          loadData()
       
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.categoryView.backgroundColor = UIColor.init(hexString: "92782E")
    }
    func loadData(){
        self.startLoadingActivity()
        ResturantVM.getResturantByID(resturantID: UserDefaultsAccess.sharedInstance.user?.store ?? 0) { resturant, errorMessage in
            self.stopLoadingActivity()
                if resturant != nil {
                    self.resturant =  resturant
                    if self.activeViewController == self.resturantFoodCategories {
                        self.resturantFoodCategories.resturant = resturant
                        
                        self.resturantFoodCategories.loadTable()
                    }
                    else {
                        self.resturantimagesVc.resturant = resturant
                        self.activeViewController =  self.resturantimagesVc
                        self.resturantimagesVc.loadImages()
                    }
                   
                }
                else {
                    
            }
        }
    }
    @IBAction func showResturantImages(_ sender: Any) {
        self.imagesView.backgroundColor = UIColor.init(hexString: "92782E")
        self.categoryView.backgroundColor = UIColor.init(hexString: "C5A23F")

        if activeViewController != resturantimagesVc {
            self.activeViewController =  resturantimagesVc
            self.resturantimagesVc.resturant = resturant
            self.resturantimagesVc.loadImages()
        }
        
    }
    
    
    @IBAction func showFoodCategories(_ sender: Any) {
         self.categoryView.backgroundColor = UIColor.init(hexString: "92782E")
        self.imagesView.backgroundColor = UIColor.init(hexString: "C5A23F")

        if activeViewController != resturantFoodCategories {
            self.activeViewController =  resturantFoodCategories
        }
        
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
