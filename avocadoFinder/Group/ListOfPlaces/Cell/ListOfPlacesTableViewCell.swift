//
//  ListOfPlacesTableViewCell.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 3/30/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class ListOfPlacesTableViewCell: UITableViewCell {

    // - UI
    @IBOutlet weak var fruilImageView: UIImageView!
    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var shopAddressLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }

    func set(shop: ShopModel) {
        shopNameLabel.text = shop.name
        shopAddressLabel.text = shop.address
        shop.type == PlaceType.store.rawValue ? (fruilImageView.image = #imageLiteral(resourceName: "avoFruit")) : (fruilImageView.image = #imageLiteral(resourceName: "foodPin"))
    }
    
}

// MARK: -
// MARK: - Configure

extension ListOfPlacesTableViewCell {
    
    func configure() {
        configureMainView()
    }
    
    func configureMainView() {
        mainView.layer.cornerRadius = 16
        mainView.setupShadow(color: AppColor.black(alpha: 0.1))
    }
    
}
