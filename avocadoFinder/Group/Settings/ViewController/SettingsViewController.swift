//
//  SettingsViewController.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 4/20/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // - UI
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mininaAvatarImageView: UIImageView!
    @IBOutlet weak var nadzeyaAvatarImageView: UIImageView!
    @IBOutlet weak var yanaAvatarImageView: UIImageView!
    
    // - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
}

// MARK: -
// MARK: - Navigation

extension SettingsViewController {
    
    @IBAction func mininaIGOpenButtonAction(_ sender: Any) {
        openIGProfile(user: "minina_a")
    }
    
    @IBAction func nadzeyaIGOpenButtonAction(_ sender: Any) {
        openIGProfile(user: "nadzeyasavitskaya")
    }
    
    @IBAction func yanaIGOpenButtonAction(_ sender: Any) {
        openIGProfile(user: "yana.poddubskaya")
    }
    
    @IBAction func rulesOfUseButtonAction(_ sender: Any) {
        openStaticPage()
    }
    
    @IBAction func termsOfCondButtonAction(_ sender: Any) {
        openStaticPage()
    }
    
    func openIGProfile(user: String) {
        let instagramHooks = "instagram://user?username=\(user)"
        let instagramUrl = NSURL(string: instagramHooks)
        if UIApplication.shared.canOpenURL(instagramUrl! as URL) {
            UIApplication.shared.openURL(instagramUrl! as URL)
        } else {
            //redirect to safari because the user doesn't have Instagram
            UIApplication.shared.openURL(NSURL(string: "http://instagram.com/\(user)")! as URL)
        }
    }
    
    func openStaticPage() {
        let staticPageViewController = UIStoryboard(storyboard: .staticPage).instantiateInitialViewController() as! StaticPageViewController
        self.navigationController?.pushViewController(staticPageViewController, animated: true)
    }
    
}



// MARK: -
// MARK: - Configure

extension SettingsViewController {
    
    func configure() {
        configureMainView()
        configureAvatars()
    }
    
    func configureMainView() {
        mainView.layer.cornerRadius = 16
        mainView.setupShadow(color: AppColor.black(alpha: 0.1))
    }
    
    func configureAvatars() {
        mininaAvatarImageView.layer.cornerRadius = 20
        nadzeyaAvatarImageView.layer.cornerRadius = 20
        yanaAvatarImageView.layer.cornerRadius = 20
        mininaAvatarImageView.layer.masksToBounds = true
        nadzeyaAvatarImageView.layer.masksToBounds = true
        yanaAvatarImageView.layer.masksToBounds = true
    }
    
}
