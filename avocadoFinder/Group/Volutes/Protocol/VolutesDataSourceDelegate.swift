//
//  VolutesDataSourceDelegate.swift
//  avocadoFinder
//
//  Created by Nick Poe on 1/14/20.
//  Copyright © 2020 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

protocol VolutesDataSourceDelegate: class {
    func didTapOnCell(volute: String)
}
