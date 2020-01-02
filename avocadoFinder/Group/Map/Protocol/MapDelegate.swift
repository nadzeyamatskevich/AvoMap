//
//  MapDelegate.swift
//  avocadoFinder
//
//  Created by Nick Poe on 1/1/20.
//  Copyright © 2020 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

protocol MapDelegate: class {
    func didTapOnCell(shop: ShopModel)
}
