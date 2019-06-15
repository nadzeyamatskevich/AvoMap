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

    func set() {}

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
