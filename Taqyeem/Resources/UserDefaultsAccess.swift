//
//  UserDefaultsAccess.swift
//  Taqyeem
//
//  Created by Mostafa sayed on 11/19/19.
//  Copyright © 2019 mazeedit. All rights reserved.
//

import Foundation
class UserDefaultsAccess {
    static let sharedInstance = UserDefaultsAccess()
    let defaults = UserDefaults.standard
    var skippedLogin = false
    var token: String {
        get {
            if let token = defaults.object(forKey: "token") as? String {
                return token
            }
            return ""
        } set {
            defaults.set(newValue, forKey: "token")
        }
    }
    func clearData() {
        token = ""
    }
}
