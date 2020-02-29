//
//  KeychainManager.swift
//  avocadoFinder
//
//  Created by Nick Poe on 1/14/20.
//  Copyright © 2020 Nadzeya Savitskaya. All rights reserved.
//

import Foundation
import KeychainAccess

struct KeychainManager {
    static let shared = KeychainManager()
    
    let keychain = Keychain(service: Constants.service).synchronizable(true)
    
    func deleteKeychainData() {
        keychain[Constants.id] = nil
        keychain[Constants.name] = nil
        UserDefaults.standard.set(nil, forKey: Constants.id)
        UserDefaults.standard.set(nil, forKey: Constants.name)
    }
    
    var id: String? {
        do {
            return try keychain.getString(Constants.id)
        } catch _ {
            return nil
        }
    }
    
    var name: String? {
        do {
            return try keychain.getString(Constants.name)
        } catch _ {
            return nil
        }
    }
    
    func saveUserID(_ userID: String) {
        do {
            try keychain.set(userID, key: Constants.id)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func saveName(_ name: String?) {
        if let namee = name {
            do {
                try keychain.set(namee, key: Constants.name)
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            //keychain.remove(Constants.name)
            return
        }
        
    }
    
}

