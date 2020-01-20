//
//  VoluteTableViewCell.swift
//  avocadoFinder
//
//  Created by Nick Poe on 1/14/20.
//  Copyright © 2020 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class VoluteTableViewCell: UITableViewCell {

    // - UI
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var keyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(key: String, title: String, image: UIImage) {
        self.keyLabel.text = key
        self.titleLabel.text = title
        self.flagImageView.image = image
    }

}
