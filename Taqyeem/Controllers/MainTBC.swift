//
//  MainTBC.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/18/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit

class MainTBC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func setTabbarImages() {
           guard let vcs = viewControllers else { return }

           vcs.enumerated().forEach {
               index, vc in

               switch (vc as! UINavigationController).topViewController
               {
               case let vc where vc is HomeVC:
                   tabBar.items?[index].selectedImage = UIImage(named: "home_selected")?.withRenderingMode(.alwaysOriginal)
                   tabBar.items?[index].image = UIImage(named: "home")?.withRenderingMode(.alwaysOriginal)
                   tabBar.items?[index].title = ""//localize("Search") // Profile
                   tabBar.items?[index].tag = index

               case let vc where vc is ContactVC:
                   tabBar.items?[index].selectedImage = UIImage(named: "contact_us_selected")?.withRenderingMode(.alwaysOriginal)
                   tabBar.items?[index].image = UIImage(named: "contact_us")?.withRenderingMode(.alwaysOriginal)
                   tabBar.items?[index].title = ""//localize("Offers") // Ads
                   tabBar.items?[index].tag = index

               case let vc where vc is SettingsVC:
                   tabBar.items?[index].selectedImage = UIImage(named: "settings_selected")?.withRenderingMode(.alwaysOriginal)
                   tabBar.items?[index].image = UIImage(named: "settings")?.withRenderingMode(.alwaysOriginal)
                   tabBar.items?[index].title = ""//localize("Profile") // Reachers
                   tabBar.items?[index].tag = index

               default: break
               }
           }
       }
}
