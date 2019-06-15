//
//  AddNewPlaceViewController.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 3/30/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class AddNewPlaceViewController: UIViewController {
    
    // - UI
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    

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

extension AddNewPlaceViewController {
    @IBAction func saveNewPlaceAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: -
// MARK: - Configure

extension AddNewPlaceViewController {
    
    func configure() {
        configureMainView()
        configureSaveButton()
    }
    
    func configureMainView() {
        mainView.layer.cornerRadius = 16
        mainView.setupShadow(color: AppColor.black(alpha: 0.1))
    }
    
    func configureSaveButton() {
        saveButton.layer.cornerRadius = 16
        saveButton.setupShadow(color: AppColor.black(alpha: 0.1))
    }
    
}

