//
//  AppDelegate.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/18/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import UIWindowTransition
import GoogleMaps
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        UINavigationBar.appearance().barTintColor = UIColor(hexString: "#CCA121")
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        GMSServices.provideAPIKey("AIzaSyBhfdHUoQrmn85ARcBxZPaO9dNxssz9wSo")
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }
    
}

