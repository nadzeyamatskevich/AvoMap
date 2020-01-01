//
//  ParalaxTableView.swift
//  avocadoFinder
//
//  Created by Nick Poe on 12/29/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class ParalaxTableView: UITableView {

    var heightConstraint: NSLayoutConstraint?
    var bottomConstraint: NSLayoutConstraint?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let header = tableHeaderView else { return }
        if heightConstraint == nil {
            if let imageView = header.subviews.first as? UIImageView {
                heightConstraint = imageView.constraints.filter{ $0.identifier == "height" }.first
                bottomConstraint = header.constraints.filter{ $0.identifier == "bottom" }.first
            }
        }
        
        let offsetY = -contentOffset.y
        bottomConstraint?.constant = offsetY >= 0 ? 0 : offsetY / 2
        heightConstraint?.constant = max(header.bounds.height, header.bounds.height + offsetY)
        

        header.clipsToBounds = offsetY <= 0
    }
}
