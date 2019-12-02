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
    @IBOutlet weak var timeLabel: UILabel!
    
    // - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

// MARK: -
// MARK: - Set

extension PlaceInfoCommentTableViewCell {
    
    func set(comment: CommentModel) {
        timeLabel.text = formatDate(date: comment.inserted_at)
        userLabel.text = comment.author
        commentLabel.text = comment.body
    }
    
    func formatDate(date: String) -> String {
        if let currentDate = Date.stringToDate(dateString: date) {
            return currentDate.dateToStringTimeDMY()
        }
        return Date().dateToStringTimeDMY()
    }
    
}

