//
//  AvoPopupViewController.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 12/20/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class AvoPopupViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var avoBackView: UIView!
    @IBOutlet weak var avoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var alertButton: UIButton!
    
    var alertTitle = ""
    var alertSubtitle = ""
    var buttonText = ""

    var alertButtonHandler: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureAppearance()
        titleLabel.text = alertTitle
        subtitleLabel.text = alertSubtitle
        alertButton.setTitle(buttonText, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showAnimate()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hideAnimate()
    }
    
    // MARK: - Navigation

    @IBAction func alertButtonAction(_ sender: Any) {
        guard let handler = alertButtonHandler else {
            dismiss(animated: false, completion: nil)
            return
        }
        handler()
    }

    func configureAppearance() {
        mainView.layer.cornerRadius = 10
        avoBackView.layer.cornerRadius = 125 / 2
        alertButton.layer.cornerRadius = 5
    }

    func set(title: String, subtitle: String, buttonText: String) {
        alertTitle = title
        alertSubtitle = subtitle
        self.buttonText = buttonText
    }

    func showAnimate() {
        self.view.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 1
        })
    }

    func hideAnimate() {
        self.view.alpha = 1
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 0
        })
    }

}
