//
//  OneNewsInfoLayoutManager.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 6/25/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit
import SDWebImage

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
        configureImage()
    }
    
    func configureImage() {
        let url = URL(string: viewController.news.image_url)
        viewController.imageView.sd_setImage(with: url, placeholderImage: viewController.image)
    }
}
