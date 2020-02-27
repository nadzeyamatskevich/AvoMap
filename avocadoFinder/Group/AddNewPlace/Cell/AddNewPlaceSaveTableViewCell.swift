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
    @IBOutlet weak var saveButton: UIButton!
    
    var delegate: AddNewPlaceSaveCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.saveButton.layer.cornerRadius = 18
    }
    
    func changeType(isAVO: Bool) {
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.saveButton.backgroundColor = isAVO ? AppColor.avo : AppColor.orange
        }
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        self.delegate?.saveNewPlace()
    }
    
    func setType(type: TypeOfFruit) {
        saveButton.backgroundColor = type == .avocado ? AppColor.avo : AppColor.orange
    }

}
