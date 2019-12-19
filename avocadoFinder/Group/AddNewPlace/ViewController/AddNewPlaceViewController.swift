//
//  AddNewPlaceViewController.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 3/30/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit
import GooglePlaces

class AddNewPlaceViewController: UIViewController {
    
    // - UI
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var shopNameTextField: UITextField!
    @IBOutlet weak var shopAddressTextField: UITextField!
    @IBOutlet weak var shopAuthorTextField: UITextField!
    @IBOutlet weak var commentTextField: UITextField!
    
    // - Manager
    fileprivate var serverManager = MapServerManager()
    fileprivate var layoutManager: AddNewPlaceLayoutManager!
    
    // - Data
    let newShop = ShopModel()
    
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
    
    @IBAction func openMapAction(_ sender: Any) {
        let addShopMapViewController = UIStoryboard(storyboard: .addShopMap).instantiateInitialViewController() as! AddShopMapViewController
        addShopMapViewController.delegate = self
        self.shopAddressTextField.isSelected = false
        self.navigationController?.pushViewController(addShopMapViewController, animated: true)
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

        geocoder.reverseGeocodeCoordinate(coordinate) { response , error in
            if let address = response?.firstResult() {
                let lines = address.lines! as [String]
                self.shopAddressTextField.text = lines.joined(separator: "\n")
            }
        }
    }
    
}

extension AddNewPlaceViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        shopAddressTextField.text = place.name
        newShop.longitude = "\(place.coordinate.longitude)"
        newShop.latitude = "\(place.coordinate.latitude)"
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
        if shopNameTextField.text == "" {
            self.showAlert(title: "Упс, ошибка!", message: "Напишите название магазина :)")
        } else if shopAddressTextField.text == "" {
            self.showAlert(title: "Упс, ошибка!", message: "Напишите адрес магазина :)")
        } else if shopAuthorTextField.text == "" {
            self.showAlert(title: "Упс, ошибка!", message: "Напишите свое имя :)")
        } else if commentTextField.text == "" {
            self.showAlert(title: "Упс, ошибка!", message: "Напишите комментарий или цену :)")
        } else if commentTextField.text?.count ?? 0 > 280 {
            self.showAlert(title: "Упс, ошибка!", message: "Комментарий должен быть до 280 символов :)")
        } else {
            return true
        }
        return false
    }
    
    func createShopModel() -> ShopModel {
        newShop.name = shopNameTextField.text!
        newShop.address = shopAddressTextField.text!
        newShop.author = shopAuthorTextField.text!
        newShop.shopDescription = commentTextField.text!
        return newShop
    }
    
    func saveAuthorName() {
        UserDefaults.standard.set(shopAuthorTextField.text ?? "", forKey: UserDefaultsEnum.authorNameKey.rawValue)
    }
    
}

// MARK: -
// MARK: - Server

extension AddNewPlaceViewController {
    
    func postShopRequest(shop: ShopModel, completion: @escaping ((_ successModel: ShopModel?, _ error: ErrorModel?) -> ())) {
        serverManager.postShop(shop: shop, completion: completion)
    }
    
    func addShop(shop: ShopModel) {
        postShopRequest(shop: shop) { [weak self] (response, error) in
            guard let strongSelf = self else { return }
            if error != nil {
                strongSelf.showAlert(title: "Упс, ошибка!", message: "Попробуйте позже")
            } else if response != nil {
                strongSelf.showAlert(title: "Отлично!", message: "Наводка сохранена :) Спасибо.", completion: {
                    strongSelf.navigationController?.popViewController(animated: true)
                })
            }
        }
    }
    
}

// MARK: -
// MARK: - Configure

extension AddNewPlaceViewController {
    
    func configure() {
        configureLayoutManager()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func configureLayoutManager() {
        layoutManager = AddNewPlaceLayoutManager(viewController: self)
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

