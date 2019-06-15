//
//  TabBarItemEnum.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 5/4/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

enum TabBarItemType: Int {
    case news = 0
    case map
    case settings
    
    var title: String {
        switch self {
        case .news:
            return "Новости"
        case .map:
            return "Карта"
        case .settings:
            return "Настройки"
        }
    }
    
    var image: UIImage {
        switch self {
        case .news:
            return #imageLiteral(resourceName: "news")
        case .map:
            return #imageLiteral(resourceName: "map")
        case .settings:
            return #imageLiteral(resourceName: "settings")
        }
    }
    
    var selectedImage: UIImage {
        switch self {
        case .news:
            return #imageLiteral(resourceName: "newsSelect")
        case .map:
            return #imageLiteral(resourceName: "mapSelect")
        case .settings:
            return #imageLiteral(resourceName: "settingsSelect")
        }
    }
}
