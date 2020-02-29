//
//  SettingsViewController.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 4/20/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit
import Firebase
import MessageUI

class SettingsViewController: UIViewController {
    
    // - UI
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBarBgImageView: UIImageView!
    @IBOutlet weak var avoImage: UIImageView!
    
    // - Manager
    private var dataSource: SettingsDataSource!
    private var cellConfigurator: SettingsCellConfigurator!
    private let userDefaultsManager = UserDefaultsManager()

    
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
    
    func changType(type: TypeOfFruit) {
        let image = type == .avocado ? UIImage(named: "navBarBg") : UIImage(named: "orangeNavBar")
        avoImage.isHidden = type == .mango
        navBarBgImageView.image = image
    }
    
}

// MARK: -
// MARK: - Navigation

extension SettingsViewController: SettingsDataSourceDelegate, MFMailComposeViewControllerDelegate {
    
    func didTapOnCell(value: String) {
        openStaticPage(value: value)
    }
    
    func changeName() {
        let alert = UIAlertController(title: "Введите новое имя", message: "", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.text = KeychainManager.shared.name ?? ""
        }

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            KeychainManager.shared.saveName(textField?.text)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func openStaticPage(value: String) {
        switch value {
        case AppDocuments.privacyPolicy.rawValue:
            UIApplication.shared.open(NSURL(string: AppDocuments.privacyPolicy.urlForDocument)! as URL, options: [:], completionHandler: nil)
        case AppDocuments.termsAndCondition.rawValue:
            UIApplication.shared.open(NSURL(string: AppDocuments.termsAndCondition.urlForDocument)! as URL, options: [:], completionHandler: nil)
        case AppInfoCell.changeName.rawValue:
            changeName()
        default:
            sendEmail(topic: value)
        }
    }
    
    func sendEmail(topic: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["avomapminsk@gmail.com"])
            mail.setMessageBody("<p>\(topic)</p>", isHTML: true)

            addAnalyticsEventOpenEmail(type: topic)
            present(mail, animated: true)
        } else {
            showAlert(title: "Ошибка!", message: "У вас не настроена почта, поэтому вы можете нам написать в директ инстаграмма)")
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
}

// MARK: -
// MARK: - Configure

extension SettingsViewController {
    
    func configure() {
        setupCellConfigurator()
        configureDataSource()
        configureTableView()
        addAnalyticsEvent()
        configureNavBar()
    }
    
    func configureDataSource() {
        dataSource = SettingsDataSource(tableView: tableView, cellItems: cellConfigurator.configure())
        dataSource.delegate = self
    }
    
    func setupCellConfigurator() {
        cellConfigurator = SettingsCellConfigurator()
    }
    
    func configureTableView() {
        tableView.layer.masksToBounds = true
        tableView.layer.cornerRadius = 16
    }
    
    func addAnalyticsEvent() {
        Analytics.logEvent("open_settings", parameters: [:])
    }
    
    func addAnalyticsEventOpenEmail(type: String) {
        Analytics.logEvent("send_email", parameters: [
            "type": type as NSObject
        ])
    }
    
    func configureNavBar() {
        let type = userDefaultsManager.get(data: .type)
        let image = type == "\(TypeOfFruit.mango)" ?  #imageLiteral(resourceName: "orangeNavBar") : #imageLiteral(resourceName: "navBarBg")
        avoImage.isHidden = type == "\(TypeOfFruit.mango)"
        navBarBgImageView.image = image
    }
    
}
