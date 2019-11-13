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
    @IBOutlet weak var firstTitle: UILabel!
    @IBOutlet weak var secondTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // - Manager
    fileprivate var layoutManager: OneNewsInfoLayoutManager!
    
    // - Data
    var news = NewsModel()
    
    // - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
}

// MARK: -
// MARK: - Actions

extension OneNewsInfoViewController {
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


// MARK: -
// MARK: - Configure

extension OneNewsInfoViewController {
    
    func configure() {
        configureLayoutManager()
    }
    
    func configureLayoutManager() {
        self.secondTitle.text = self.news.subtitle
        self.firstTitle.text = self.news.title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "OneNewsImageCell") as! OneNewsImageCell
            cell.set(image: self.news.image_url)
            return cell
        default:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "OneNewsTextCell") as! OneNewsTextCell
            cell.set(text: self.news.body)
            return cell
        }
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
