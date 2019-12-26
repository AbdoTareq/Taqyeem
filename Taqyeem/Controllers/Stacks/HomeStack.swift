//
//  HomeStack.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/23/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit
class HomeStack: UIStackView {
    @IBOutlet weak var vwFav: UIView!
    @IBOutlet weak var vwSearch: UIView!
    @IBOutlet weak var vwGeneralNews: UIView!
    @IBOutlet weak var vwbulletain: UIView!
    @IBOutlet weak var vwEGate: UIView!
    @IBOutlet weak var vwAbout: UIView!
    
    @IBOutlet weak var stackFirst: UIStackView!
    @IBOutlet weak var stackSecond: UIStackView!
    @IBOutlet weak var stackThird: UIStackView!
    
    
    func initGestures() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(goToSearch(_:)))
        vwSearch.addGestureRecognizer(tapGestureRecognizer)
        
        let favGesture = UITapGestureRecognizer(target: self, action: #selector(goToFav))
        vwFav.addGestureRecognizer(favGesture)
        
        let generalNewsGesture = UITapGestureRecognizer(target: self, action: #selector(goToGeneralNews))
        vwGeneralNews.addGestureRecognizer(generalNewsGesture)
        
        let bulletainGesture = UITapGestureRecognizer(target: self, action: #selector(goToBulletain))
        vwbulletain.addGestureRecognizer(bulletainGesture)
        
        let aboutGesture = UITapGestureRecognizer(target: self, action: #selector(goToAbout))
        vwAbout.addGestureRecognizer(aboutGesture)
    }
    @objc func goToSearch(_: UITapGestureRecognizer) {
        let nextVC = UIApplication.topViewController()!.storyboard?.instantiateViewController(withIdentifier: "ResturantSearchVC") as! ResturantSearchVC
        UIApplication.topViewController()!.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func goToFav(_: UITapGestureRecognizer) {
        if UserDefaultsAccess.sharedInstance.user == nil {
            UIApplication.topViewController()!.logOut()
            return
        }
        let nextVC = UIApplication.topViewController()!.storyboard?.instantiateViewController(withIdentifier: "FavouritesVC") as! FavouritesVC
        UIApplication.topViewController()!.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func goToGeneralNews(_: UITapGestureRecognizer) {
        let nextVC = UIApplication.topViewController()!.storyboard?.instantiateViewController(withIdentifier: "GeneralNewsVC") as! GeneralNewsVC
        UIApplication.topViewController()!.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func goToBulletain(_: UITapGestureRecognizer) {
        let nextVC = UIApplication.topViewController()!.storyboard?.instantiateViewController(withIdentifier: "BulletainVC") as! BulletainVC
        UIApplication.topViewController()!.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func goToAbout(_: UITapGestureRecognizer) {
        let nextVC = UIApplication.topViewController()!.storyboard?.instantiateViewController(withIdentifier: "AboutVC") as! AboutVC
        UIApplication.topViewController()!.navigationController?.pushViewController(nextVC, animated: true)
    }
}
