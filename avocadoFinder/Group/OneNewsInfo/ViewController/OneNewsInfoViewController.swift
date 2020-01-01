//
//  OneNewsInfoViewController.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 4/20/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit
import Kingfisher

class OneNewsInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // - UI
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var firstTitle: UILabel!
    @IBOutlet weak var secondTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // - Constraint
    @IBOutlet weak var upButtonBottomConstraint: NSLayoutConstraint!
    
    // - Manager
    fileprivate var layoutManager: OneNewsInfoLayoutManager!
    
    // - Data
    var news = NewsModel()
    var image: UIImage?
    
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
    
}

// MARK: -
// MARK: - Actions

extension OneNewsInfoViewController {
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func upButtonAction(_ sender: UIButton) {
        tableView.setContentOffset(.zero, animated: true)
    }
    
}

// MARK: -
// MARK: - Update

extension OneNewsInfoViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        upButtonBottomConstraint.constant = -250 + (self.tableView.contentOffset.y * 1.3)
        if upButtonBottomConstraint.constant > 25 { upButtonBottomConstraint.constant = 25}
    }
    
}


// MARK: -
// MARK: - Configure

extension OneNewsInfoViewController {
    
    func configure() {
        configureLayoutManager()
        upButtonBottomConstraint.constant = -200
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    func configureLayoutManager() {
        layoutManager = OneNewsInfoLayoutManager(viewController: self)
        self.secondTitle.text = self.news.subtitle
        self.firstTitle.text = self.news.title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "OneNewsTextCell") as! OneNewsTextCell
        cell.set(text: self.news.body)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

class OneNewsImageCell: UITableViewCell {
    
    // - UI
    @IBOutlet weak var newsImageView: UIImageView!
       
    // - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(image: String) {
        newsImageView.kf.setImage(with: URL(string: image))
    }

}

class OneNewsTextCell: UITableViewCell {
    
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
