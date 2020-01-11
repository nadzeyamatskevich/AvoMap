//
//  AppAuthors.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 7/13/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import Foundation

enum AppAuthors: String {
    case minina = "@minina_a"
    case nadzeyasavitskaya = "@nadzeyasavitskaya"
    case yanaPoddubskaya = "@yana.poddubskaya"
    case katyarunkevich = "@katyarunkevich"
    case antonsavicky = "@anton.savitski"
    case avoMap = "@avo_map"
    
    var avatarImage: String {
        switch self {
        case .minina:
            return "minina"
        case .nadzeyasavitskaya:
            return "nadzeya"
        case .yanaPoddubskaya:
            return "yana"
        case .antonsavicky:
            return "antonsav"
        case .katyarunkevich:
            return "katya"
        case .avoMap:
            return "avoMap"
        }
    }
    
}

enum AppDocuments: String {
    case privacyPolicy = "Privacy Policy"
    case termsAndCondition = "Terms & Conditions"
    
    var urlForDocument: String {
        switch self {
        case .privacyPolicy:
            return "https://avo-map.gitlab.io/privacy-policy"
        case .termsAndCondition:
            return "https://avo-map.gitlab.io/terms-and-conditions"
        }
    }
}

enum AppInfo: String {
    case addPlace = "Предложить заведение"
    case proposeWork = "Предложить сотрудничество"
}
