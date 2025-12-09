//
//  UserDefaultsManager.swift
//  ParkSpace
//
//  Created by Zubair Ahmed on 02/03/2022.
//

import Foundation
import UIKit

fileprivate enum UserDefaultsKey : String {
    case userId
    case authToken
    case deviceToken
    case wallet
}

fileprivate class UserDefault {
    static func _set(value : Any?, key : UserDefaultsKey) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    static func _get(valueForKey  Key: UserDefaultsKey) -> Any? {
        return UserDefaults.standard.value(forKey: Key.rawValue)
    }
}

class UserDefaultsManager {
    class var shared: UserDefaultsManager {
        struct Static {
            static let instance = UserDefaultsManager()
        }
        return Static.instance
    }
    
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
    var userId : String {
        set{
            UserDefault._set(value: newValue, key: .userId)
        } get {
            return UserDefault._get(valueForKey: .userId) as? String ?? "0"
        }
    }
    
    var authToken : String {
        set{
            UserDefault._set(value: newValue, key: .authToken)
        } get {
            return UserDefault._get(valueForKey: .authToken) as? String ?? ""
        }
    }
    
    var deviceToken: String {
        set{
            UserDefault._set(value: newValue, key: .deviceToken)
        } get {
            return UserDefault._get(valueForKey: .deviceToken) as? String ?? ""
        }
    }
    
    var wallet: String {
        set {
            UserDefault._set(value: newValue, key: .wallet)
        } get {
            return UserDefault._get(valueForKey: .wallet) as? String ?? ""
        }
    }
}
