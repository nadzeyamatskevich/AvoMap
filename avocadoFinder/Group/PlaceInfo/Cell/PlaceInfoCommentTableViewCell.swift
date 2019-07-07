//
//  PlaceInfoCommentTableViewCell.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 5/12/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class PlaceInfoCommentTableViewCell: UITableViewCell {

    // - UI
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    // - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(comment: CommentModel) {
        userLabel.text = comment.author
        commentLabel.text = comment.body
    }

}
