//
//  StaticPageViewController.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 4/20/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class StaticPageViewController: UIViewController {

    // - UI
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainTextTextView: UIWebView!
    
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
// MARK: - Actions

extension StaticPageViewController {
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: -
// MARK: - Configure

extension StaticPageViewController {
    
    func configure() {
        configureMainText()
    }
    
    func configureMainText() {
        mainTextTextView.loadRequest(URLRequest(url: URL(string: "https://avo-map.gitlab.io/privacy-policy")!))
    }
    
    func configureHTML(html: String) {
        mainTextTextView.loadHTMLString("<span style= color: #000000\">\(html)</span>", baseURL: nil)
    }
    
}
