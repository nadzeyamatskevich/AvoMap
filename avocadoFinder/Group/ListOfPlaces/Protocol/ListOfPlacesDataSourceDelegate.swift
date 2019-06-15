//
//  ListOfPlacesDataSourceDelegate.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 5/12/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

protocol ListOfPlacesDataSourceDelegate: class {
    func didTapOnCell(shop: Int)
}
