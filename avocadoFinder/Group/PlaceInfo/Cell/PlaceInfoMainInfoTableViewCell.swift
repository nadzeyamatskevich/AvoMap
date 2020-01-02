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
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var triangleView: TriangleView!
    
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
        
        let labelTapGesture = UILongPressGestureRecognizer(target:self,action:#selector(copyToClipboard))
        instagramLabel.isUserInteractionEnabled = true
        instagramLabel.addGestureRecognizer(labelTapGesture)
    }
}

// MARK: -
// MARK: - Configure

extension PlaceInfoMainInfoTableViewCell {
    
    func configure() {
        configureMainView()
        configurePopupView()
        configureTriangleView()
    }
    
    func configureMainView() {
        mainView.layer.cornerRadius = 16
        mainView.setupShadow(color: AppColor.black(alpha: 0.1))
    }
    
    func configurePopupView() {
        self.popupView.alpha = 0.0
        self.popupView.layer.cornerRadius = 8
    }
    
    func configureTriangleView() {
        self.triangleView.alpha = 0.0
    }
    
}

// MARK: -
// MARK: - Action

extension PlaceInfoMainInfoTableViewCell {
    
    @objc func copyToClipboard() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = self.instagramLabel.text
        if self.popupView.alpha == 0.0 {
            self.popupView.alpha = 1.0
            self.triangleView.alpha = 1.0
        } else {
            UIView.animate(withDuration: 0.5, delay: 2, options: .curveEaseOut, animations: {
                self.popupView.alpha = 0.0
                self.triangleView.alpha = 0.0
            })
        }
    }
}
