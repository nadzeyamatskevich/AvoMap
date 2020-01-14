//
//  AddNewPlaceSaveTableViewCell.swift
//  avocadoFinder
//
//  Created by Nick Poe on 1/14/20.
//  Copyright © 2020 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class AddNewPlaceSaveTableViewCell: UITableViewCell {
    
    // - UI
    @IBOutlet weak var viewBackgroundView: UIView!
    @IBOutlet weak var saveButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func changeType(isAVO: Bool) {
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.viewBackgroundView.backgroundColor = isAVO ? AppColor.avo : AppColor.orange
        }
    }

}
