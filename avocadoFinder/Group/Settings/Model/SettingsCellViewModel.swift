//
//  SettingsCellViewModel.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 7/13/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import Foundation

class SettingsCellViewModel {
    
    // - UI
    var type: SettingsCellType
    var value: String
    
    init(type: SettingsCellType, value: String) {
        self.type = type
        self.value = value
    }
    
}

enum SettingsCellType: String {
    case author = "AuthorSettingsCell"
    case info = "TermsInfoSettingsCell"
}
