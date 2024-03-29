//
//  PlaceInfoMainInfoTableViewCell.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 5/12/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class PlaceInfoMainInfoTableViewCell: UITableViewCell {

    // - UI
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var shopTitle: UILabel!
    @IBOutlet weak var shopAdress: UILabel!
    @IBOutlet weak var instagramLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    // - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }

    func set(shop: ShopModel) {
        shopTitle.text = shop.name
        shopAdress.text = shop.address
        instagramLabel.text = shop.author
        commentLabel.text = shop.shopDescription
    }
}

// MARK: -
// MARK: - Configure

extension PlaceInfoMainInfoTableViewCell {
    
    func configure() {
        configureMainView()
    }
    
    func configureMainView() {
        mainView.layer.cornerRadius = 16
        mainView.setupShadow(color: AppColor.black(alpha: 0.1))
    }
    
}
