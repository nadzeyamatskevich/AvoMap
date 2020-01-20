//
//  RecipeTableViewCell.swift
//  avocadoFinder
//
//  Created by Nick Poe on 1/14/20.
//  Copyright © 2020 Nadzeya Savitskaya. All rights reserved.
//

import UIKit
import Kingfisher

class RecipeTableViewCell: UITableViewCell {

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
    
    func set(recipe: RecipeModel) {
        avoImage.kf.setImage(with: URL(string: recipe.image_url))
        titleLabel.text = recipe.title
        subtitleLabel.text = recipe.subtitle
        self.layoutSubviews()
    }

}

// MARK: -
// MARK: - Configure

extension RecipeTableViewCell {
    
    func configure() {
        configureMainView()
        configureImageView()
    }
    
    func configureMainView() {
        mainView.layer.cornerRadius = 16
        mainView.setupOnlyBottomShadow(color: AppColor.black(alpha: 0.1))
    }
    
    func configureImageView() {
        avoImage.roundCorners(corners: [.bottomRight, .topRight], radius: 16)
    }

}
