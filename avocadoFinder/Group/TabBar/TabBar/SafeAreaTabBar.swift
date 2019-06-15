//
//  SafeAreaTabBar.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 5/4/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class SafeAreaTabBar: UITabBar {
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let size = super.sizeThatFits(size)
        if safeAreaIsSupported() {
            return CGSize(width: size.width, height: 89)
        } else {
            return CGSize(width: size.width, height: 56)
        }
    }
}
