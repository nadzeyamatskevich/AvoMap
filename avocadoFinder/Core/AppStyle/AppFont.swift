//
//  AppFont.swift
//  avocadoFinder
//
//  Created by Nick Poe on 12/29/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

enum AppFont {

    private static var fontNames = [
        "Circe-Bold"
    ]
    
    static func bold(size: CGFloat) -> UIFont {
        return UIFont(name: fontNames[0], size: size)!
    }
    
}
