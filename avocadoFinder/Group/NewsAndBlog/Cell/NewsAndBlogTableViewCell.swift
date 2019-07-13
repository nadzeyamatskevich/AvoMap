//
//  NewsAndBlogTableViewCell.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 5/4/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit
import Kingfisher

class NewsAndBlogTableViewCell: UITableViewCell {

    // - UI
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var avoImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    // - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    func set(news: NewsModel) {
        avoImage.kf.setImage(with: URL(string: news.image_url))
        titleLabel.text = news.title
        subtitleLabel.text = news.subtitle
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
