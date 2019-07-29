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
    @IBOutlet weak var mainTextTextView: UITextView!
    
    // - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
