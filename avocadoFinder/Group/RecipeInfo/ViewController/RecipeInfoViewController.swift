//
//  RecipeInfoViewController.swift
//  avocadoFinder
//
//  Created by Nick Poe on 1/14/20.
//  Copyright © 2020 Nadzeya Savitskaya. All rights reserved.
//

import UIKit
import Kingfisher
import Firebase

class RecipeInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // - UI
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var firstTitle: UILabel!
    @IBOutlet weak var secondTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // - Constraint
    @IBOutlet weak var upButtonBottomConstraint: NSLayoutConstraint!
    
    // - Manager
    private var layoutManager: RecipeInfoLayoutManager!
    
    // - Data
    private(set) var recipe = RecipeModel()
    private(set) var image: UIImage?
    
    // - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
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
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .none
    }
    
    func set(recipe: RecipeModel, image: UIImage?) {
        self.recipe = recipe
        self.image = image
    }
    
}

// MARK: -
// MARK: - Actions

extension RecipeInfoViewController {
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func upButtonAction(_ sender: UIButton) {
        tableView.setContentOffset(.zero, animated: true)
    }
    
}

// MARK: -
// MARK: - Update

extension RecipeInfoViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        upButtonBottomConstraint.constant = -250 + (self.tableView.contentOffset.y * 1.3)
        if upButtonBottomConstraint.constant > 25 { upButtonBottomConstraint.constant = 25}
    }
    
}


// MARK: -
// MARK: - Configure

extension RecipeInfoViewController {
    
    func configure() {
        configureLayoutManager()
        upButtonBottomConstraint.constant = -200
        self.setNeedsStatusBarAppearanceUpdate()
        addAnalyticsEvent()
    }
    
    func configureLayoutManager() {
        layoutManager = RecipeInfoLayoutManager(viewController: self)
        self.secondTitle.text = self.recipe.subtitle
        self.firstTitle.text = self.recipe.title
    }
    
   func addAnalyticsEvent() {
        Analytics.logEvent("open_news", parameters: [
            "name": self.recipe.title as NSObject
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Text") as! RecipeTextCell
        cell.set(text: self.recipe.body)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

class RecipeTextCell: UITableViewCell {
    
    // - UI
    @IBOutlet weak var newsTextLabel: UILabel!
       
    // - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(text: String) {
        self.newsTextLabel.text = text
    }

}
