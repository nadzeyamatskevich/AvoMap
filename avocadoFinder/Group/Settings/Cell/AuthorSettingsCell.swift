//
//  AuthorSettingsCell.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 7/13/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class AuthorSettingsCell: UITableViewCell {

    // - UI
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var igButton: UIButton!
    
    // - Data
    var author = AppAuthors.minina.rawValue
    
    // - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureImageView()
    }

}

// MARK: -
// MARK: - Actions

extension AuthorSettingsCell {
    
    @IBAction func igButtonAction(_ sender: Any) {
        openIGProfile(user: author)
    }
    
}

// MARK: -
// MARK: - Set

extension AuthorSettingsCell {
    
    func set(value: String) {
        author = value
        igButton.setTitle(value, for: .normal)
        setAvatar(value: value)
    }
    
    func setAvatar(value: String) {
        switch value {
        case AppAuthors.minina.rawValue:
            return avatarImageView.image = UIImage(named: AppAuthors.minina.avatarImage)
        case AppAuthors.nadzeyasavitskaya.rawValue:
            return avatarImageView.image = UIImage(named: AppAuthors.nadzeyasavitskaya.avatarImage)
        case AppAuthors.yanaPoddubskaya.rawValue:
            return avatarImageView.image = UIImage(named: AppAuthors.yanaPoddubskaya.avatarImage)
        case AppAuthors.katyarunkevich.rawValue:
            return avatarImageView.image = UIImage(named: AppAuthors.katyarunkevich.avatarImage)
        case AppAuthors.antonsavicky.rawValue:
            return avatarImageView.image = UIImage(named: AppAuthors.antonsavicky.avatarImage)
        default:
            break
        }
    }
    
}

// MARK: -
// MARK: - Configure

extension AuthorSettingsCell {
    
    func configureImageView() {
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = 20
    }
    
}

// MARK: -
// MARK: - Coordinator

extension AuthorSettingsCell {

    func openIGProfile(user: String) {
        var userName = user
        let instagramHooks = "instagram://user?username=\(userName.dropFirst())"
        let instagramUrl = NSURL(string: instagramHooks)
        if UIApplication.shared.canOpenURL(instagramUrl! as URL) {
            UIApplication.shared.openURL(instagramUrl! as URL)
        } else {
            //redirect to safari because the user doesn't have Instagram
            UIApplication.shared.openURL(NSURL(string: "http://instagram.com/\(user)")! as URL)
        }
    }
    
}
