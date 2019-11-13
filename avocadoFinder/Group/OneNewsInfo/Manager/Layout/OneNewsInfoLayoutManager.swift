//
//  OneNewsInfoLayoutManager.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 6/25/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit
import Kingfisher

class OneNewsInfoLayoutManager: NSObject {
    
    // - UI
    fileprivate unowned let viewController: OneNewsInfoViewController
    
    init(viewController: OneNewsInfoViewController) {
        self.viewController = viewController
        super.init()
        configure()
    }
    
}

// MARK: -
// MARK: - Configure

fileprivate extension OneNewsInfoLayoutManager {
    
    func configure() {
        configureData()
    }
    
    func configureData() {
        
    }
}
