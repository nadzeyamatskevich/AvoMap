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
    case antonsavicky = "@antonsavicky"
    
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
        }
    }
}
