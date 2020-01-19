//
//  UserDefaultsManager.swift
//  avocadoFinder
//
//  Created by Nick Poe on 1/19/20.
//  Copyright © 2020 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class UserDefaultsManager: NSObject {
    
    static let shared = UserDefaultsManager()
    
    enum Data: String {
        case type = "type"
    }
    
    func get(data: Data) -> String {
        return UserDefaults.standard.string(forKey: data.rawValue) ?? ""
    }
    
    func getDouble(data: Data) -> Double {
        return UserDefaults.standard.double(forKey: data.rawValue)
    }
    
    func getInt(data: Data) -> Int {
        return UserDefaults.standard.integer(forKey: data.rawValue)
    }
    
    func getBool(data: Data) -> Bool {
        return UserDefaults.standard.bool(forKey: data.rawValue)
    }
    
    func save(value: String, data: Data) {
        UserDefaults.standard.set(value, forKey: data.rawValue)
    }
    
    func save(value: Int, data: Data) {
        UserDefaults.standard.set(value, forKey: data.rawValue)
    }
    
    func save(value: Bool, data: Data) {
        UserDefaults.standard.set(value, forKey: data.rawValue)
    }
    
    func save(value: Double, data: Data) {
        UserDefaults.standard.set(value, forKey: data.rawValue)
    }
}
