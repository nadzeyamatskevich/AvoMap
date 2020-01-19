//
//  AddNewPlaceViewController.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 3/30/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit
import GooglePlaces
import HPGradientLoading
import Firebase

class AddNewPlaceViewController: UIViewController {
    
    // - UI
    @IBOutlet weak var navBarImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    // - Constraint
    @IBOutlet weak var navigationBarHeightConstraint: NSLayoutConstraint!
    
    // - Manager
    private var serverManager = MapServerManager()
    private var layoutManager: AddNewPlaceLayoutManager!
    private var dataSource: AddNewPlaceDataSourceManager!
    
    // - Data
    private let newShop = ShopModel()
    private var userName = ""
    var type: TypeOfFruit = .avocado
    
    // - Delegate
    var delegate: MapDelegate?
    
    // - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction func addressTextFieldAction(_ sender: UITextField) {
       sender.resignFirstResponder()
       let acController = GMSAutocompleteViewController()
       acController.delegate = self
       present(acController, animated: true, completion: nil)
    }
    @IBAction func changeCurrencyButtonAction(_ sender: UIButton) {
        let volutesVC = UIStoryboard(storyboard: .volutes).instantiateInitialViewController() as! VolutesViewController
        self.present(volutesVC, animated: true, completion: nil)
    }
    
    @IBAction func changeTypeSegmentedControlAction(_ sender: UISegmentedControl) {
        let state = sender.selectedSegmentIndex == 0 ? true : false
        type = sender.selectedSegmentIndex == 0 ? .avocado : .mango
        dataSource.changeType(isAVO: state)
        layoutManager.changeNavbar(isAVO: state)
        delegate?.updateTypeAfterReturn(type: type)
    }
    
    @IBAction func openMapAction(_ sender: Any) {
        let addShopMapViewController = UIStoryboard(storyboard: .addShopMap).instantiateInitialViewController() as! AddShopMapViewController
        addShopMapViewController.delegate = self
        addAnalyticsEventMap()
        self.present(addShopMapViewController, animated: true, completion: nil)
    }
}

// MARK: -
// MARK: - Configure

extension AddNewPlaceViewController: AddShopMapDelegate {
    
    func didAddLocation(latitude: Double, longitude: Double) {
        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)

        newShop.latitude = "\(latitude)"
        newShop.longitude = "\(longitude)"
        
        let geocoder = GMSGeocoder()

        geocoder.reverseGeocodeCoordinate(coordinate) { [weak self] response , error in
            if let address = response?.firstResult() {
                let lines = address.lines! as [String]
                self?.dataSource.setAddress(lines.joined(separator: "\n"))
            }
        }
    }
    
}

extension AddNewPlaceViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        dataSource.setAddress(place.name ?? "nil")
        newShop.longitude = "\(place.coordinate.longitude)"
        newShop.latitude = "\(place.coordinate.latitude)"
        addAnalyticsEventText()
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: -
// MARK: - Actions

extension AddNewPlaceViewController {
    @IBAction func saveNewPlaceAction(_ sender: Any) {
        if checkShopInfo() {
            addShop(shop: createShopModel())
            saveAuthorName()
        }
        
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func checkShopInfo() -> Bool {
        
        if dataSource.address == "" {
            self.showAlert(title: "Упс, ошибка!", message: "Напишите название магазина :)")
        } else if dataSource.address == "" {
            self.showAlert(title: "Упс, ошибка!", message: "Напишите адрес магазина :)")
        } else if userName == "" {
            self.showAlert(title: "Упс, ошибка!", message: "Напишите свое имя :)")
        } else if dataSource.comment.count > 280 {
            self.showAlert(title: "Упс, ошибка!", message: "Комментарий должен быть до 280 символов :)")
        } else {
            return true
        }
        return false
    }
    
    func createShopModel() -> ShopModel {
        newShop.name = dataSource.name
        newShop.address = dataSource.address
        newShop.author = dataSource.userName
        newShop.shopDescription = dataSource.comment
        return newShop
    }
    
    func saveAuthorName() {
//        UserDefaults.standard.set(shopAuthorTextField.text ?? "", forKey: UserDefaultsEnum.authorNameKey.rawValue)
    }
    
}

// MARK: -
// MARK: - Server

extension AddNewPlaceViewController {
    
    func postShopRequest(shop: ShopModel, completion: @escaping ((_ successModel: ShopModel?, _ error: ErrorModel?) -> ())) {
        serverManager.postShop(shop: shop, completion: completion)
    }
    
    func addShop(shop: ShopModel) {
        HPGradientLoading.shared.showLoading()
        postShopRequest(shop: shop) { [weak self] (response, error) in
            guard let strongSelf = self else { return }
            if error != nil {
                HPGradientLoading.shared.dismiss()
                strongSelf.showAlert(title: "Упс, ошибка!", message: "Попробуйте позже")
            } else if response != nil {
                HPGradientLoading.shared.dismiss()
                strongSelf.showAlert(title: "Отлично!", message: "Наводка сохранена :) Спасибо.", completion: nil)
                self?.addAnalyticsEventAddPlace()
                strongSelf.navigationController?.popViewController(animated: true)
            }
        }
    }
    
}

// MARK: -
// MARK: - Configure

extension AddNewPlaceViewController {
    
    func configure() {
        userName = KeychainManager.shared.name ?? ""
        configureLayoutManager()
        configureDataSource()
        addAnalyticsEvent()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func configureLayoutManager() {
        layoutManager = AddNewPlaceLayoutManager(viewController: self)
    }
    
    func configureDataSource() {
        dataSource = AddNewPlaceDataSourceManager(tableView: tableView)
        dataSource.delegate = self
        dataSource.set(userName: userName, type: type)
    }
    
    func addAnalyticsEvent() {
        Analytics.logEvent("open_addNewPlace", parameters: [:])
    }
    
    func addAnalyticsEventAddPlace() {
        Analytics.logEvent("add_newPlace", parameters: [:])
    }
    
    func addAnalyticsEventMap() {
        Analytics.logEvent("newPlace_openMap", parameters: [:])
    }
    
    func addAnalyticsEventText() {
        Analytics.logEvent("newPlace_openTextField", parameters: [:])
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.height <= 667 && self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height/2
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
            self.view.endEditing(true)
        }
    }
    
}

// MARK: -
// MARK: - AddNewPlaceDelegate

extension AddNewPlaceViewController: AddNewPlaceDelegate {
    
}

