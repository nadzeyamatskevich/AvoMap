//
//  OneNewsInfoViewController.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 4/20/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class OneNewsInfoViewController: UIViewController {

    // - UI
    @IBOutlet weak var firstTitle: UILabel!
    @IBOutlet weak var secondTitle: UILabel!
    @IBOutlet weak var mainText: UITextView!
    @IBOutlet weak var mainImage: UIImageView!
    
    // - Manager
    fileprivate var layoutManager: OneNewsInfoLayoutManager!
    
    // - Data
    var news = NewsModel()
    
    // - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print(news)
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
    
    // - Actions
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension OneNewsInfoViewController {
    
    func configure() {
        configureLayoutManager()
    }
    
    func configureLayoutManager() {
        layoutManager = OneNewsInfoLayoutManager(viewController: self)
    }
}
