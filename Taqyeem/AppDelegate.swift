//
//  AppDelegate.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/18/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        UINavigationBar.appearance().barTintColor = UIColor(hexString: "#CCA121")
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]

        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func decideRootView(animated:Bool) {
        if UserDefaultsAccess.sharedInstance.skippedLogin || UserDefaultsAccess.sharedInstance.token != "" {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let objWelcomeVC = storyboard.instantiateViewController(withIdentifier: "MainTBC") as UIViewController
            if animated{
                switchView(vc: objWelcomeVC, animtion: .transitionFlipFromTop)
                return
            }
            
            window?.rootViewController = objWelcomeVC
            window?.makeKeyAndVisible()
        }else{
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let objWelcomeVC = storyboard.instantiateInitialViewController()!
            if animated{
                switchView(vc: objWelcomeVC, animtion: .transitionFlipFromTop)
                return
            }
            
            window?.rootViewController = objWelcomeVC
            window?.makeKeyAndVisible()
        }
        
    }
    
    func switchView(vc:UIViewController,animtion:UIView.AnimationOptions)
    {
        DispatchQueue.main.async
            {
                let transition: UIView.AnimationOptions = animtion
                let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
                
                let mainwindow = (UIApplication.shared.delegate?.window!)!
                //                mainwindow.backgroundColor = UIColor(hue: 0.6477, saturation: 0.6314, brightness: 0.6077, alpha: 0.8)
                
                rootviewcontroller.rootViewController = vc
                
                UIView.transition(with: mainwindow, duration: 0.55001, options: transition, animations: nil, completion: nil)
        }
    }
}

