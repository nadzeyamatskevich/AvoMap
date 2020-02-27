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

}

// MARK: -
// MARK: - Delegates

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
        newShop.name = place.name ?? ""
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

extension AddNewPlaceViewController: AddNewPlaceMainCellDelegate {

    func openGoogleAutocompleteVC(_ sender: UITextField) {
        sender.resignFirstResponder()
        let acController = GMSAutocompleteViewController()
        acController.delegate = self
        present(acController, animated: true, completion: nil)
    }
    
    func openMap() {
        let addShopMapViewController = UIStoryboard(storyboard: .addShopMap).instantiateInitialViewController() as! AddShopMapViewController
        addShopMapViewController.delegate = self
        addAnalyticsEventMap()
        self.present(addShopMapViewController, animated: true, completion: nil)
    }

}

extension AddNewPlaceViewController: AddNewPlaceSaveCellDelegate {
    
    func saveNewPlace() {
        if checkShopInfo() {
            addShop(shop: createShopModel())
            saveAuthorName()
        }
    }

}

extension AddNewPlaceViewController: AddNewPlaceDescriptionCellDelegate {
    func changeFruitType(selectedSegment: Int) {
        let state = selectedSegment == 0 ? true : false
        type = selectedSegment == 0 ? .avocado : .mango
        dataSource.changeType(isAVO: state)
        layoutManager.changeNavbar(isAVO: state)
        delegate?.updateTypeAfterReturn(type: type)
    }
    
    
    func openCurrencyVC() {
        let currenciesVC = UIStoryboard(storyboard: .currencies).instantiateInitialViewController() as! CurrenciesViewController
        currenciesVC.modalPresentationStyle = .fullScreen
        currenciesVC.modalTransitionStyle = .crossDissolve
        currenciesVC.modalPresentationStyle = .overCurrentContext
        currenciesVC.addNewPlaceDelegate = self
        self.present(currenciesVC, animated: true, completion: nil)
    }

}

extension AddNewPlaceViewController: AddNewPlaceDelegate {
    func setCurreny(currency: CurrencyModel) {
        UserDefaultsManager.shared.save(value: currency.currency, data: .selectedСurrency)
        dataSource.setCurrency(currency)
    }
    
    
}

// MARK: -
// MARK: - Actions

extension AddNewPlaceViewController {
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func checkShopInfo() -> Bool {
        if let mainCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? AddNewPlaceMainTableViewCell {
            if userName.count < 1 {
                userName = mainCell.shopAuthorTextField.text ?? ""
            }
            newShop.name = mainCell.shopNameTextField.text ?? ""
        }
        
        if let descriptionCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? AddNewPlaceDescriptionTableViewCell {
            newShop.shopDescription = descriptionCell.commentTextField.text ?? ""
            newShop.ripe = descriptionCell.degreeOfRipenessSegmentedControl.selectedSegmentIndex == 1 ? false : true
            newShop.price = descriptionCell.priceTextField.text ?? ""
            newShop.currency = descriptionCell.currencyLabel.text ?? ""
        }
        
        if newShop.name == "" {
            self.showAlert(title: "Упс, ошибка!", message: "Напишите название магазина :)")
        } else if dataSource.address == "" {
            self.showAlert(title: "Упс, ошибка!", message: "Напишите адрес магазина :)")
        } else if userName == "" {
            self.showAlert(title: "Упс, ошибка!", message: "Напишите свое имя :)")
        } else if newShop.shopDescription.count > 280 {
            self.showAlert(title: "Упс, ошибка!", message: "Комментарий должен быть до 280 символов :)")
        } else {
            return true
        }
        return false
    }
    
    func createShopModel() -> ShopModel {
        newShop.address = dataSource.address
        newShop.author = userName
        switch dataSource.type {
        case .avocado:
            newShop.type = PlaceType.store.rawValue
        case .mango:
            newShop.type = PlaceType.store_mango.rawValue
        }
        return newShop
    }
    
    func saveAuthorName() {
        KeychainManager.shared.saveName(userName)
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
            //guard let strongSelf = self else {return }
            print("PRINT HERE", error, response)
            if error != nil {
                HPGradientLoading.shared.dismiss()
                self?.showAlert(title: "Упс, ошибка!", message: "Попробуйте позже")
            } else if response != nil {
                HPGradientLoading.shared.dismiss()
                self?.showAlert(title: "Отлично!", message: "Наводка сохранена :) Спасибо.", completion: nil)
                self?.addAnalyticsEventAddPlace()
                self?.navigationController?.popViewController(animated: true)
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
        dataSource.descriptionCelldelegate = self
        dataSource.addNewPlaceMainCellDelegate = self
        dataSource.addNewPlaceSaveCellDelegate = self
        let currency = CurrencyManager.shared.selectedСurrency
        dataSource.set(userName: userName, type: type, currency: currency)
    }

    @objc func keyboardWillShow(_ notification:Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: keyboardSize.height + 20, right: 0)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        }
    }
    
}


//
extension AddNewPlaceViewController {
    
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
}
