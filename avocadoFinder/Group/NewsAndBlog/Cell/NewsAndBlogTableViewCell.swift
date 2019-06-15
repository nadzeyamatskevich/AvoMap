//
//  NewsAndBlogTableViewCell.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 5/4/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class NewsAndBlogTableViewCell: UITableViewCell {

    // - UI
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var avoImage: UIImageView!
    
    // - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }

}

// MARK: -
// MARK: - Configure

extension NewsAndBlogTableViewCell {
    
    func configure() {
        configureMainView()
        configureImageView()
    }
    
    func configureMainView() {
        mainView.layer.cornerRadius = 16
        mainView.setupShadow(color: AppColor.black(alpha: 0.1))
    }
    
    func configureImageView() {
        avoImage.roundCorners(corners: [.bottomRight, .topRight], radius: 16)
    }

}
