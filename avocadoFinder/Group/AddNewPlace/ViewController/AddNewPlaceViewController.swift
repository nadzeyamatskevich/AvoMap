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
    
    // - Manager
    fileprivate var serverManager = MapServerManager()
    fileprivate var geocoder = CLGeocoder()
    
    // - Data
    let newShop = ShopModel()
    
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
    
    @IBAction func addressTextFieldAction(_ sender: Any) {
        //shopAddressTextField.resignFirstResponder()
        //let acController = GMSAutocompleteViewController()
        //acController.delegate = self
        //present(acController, animated: true, completion: nil)
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
        } else {
            return true
        }
        return false
    }
    
    func createShopModel() -> ShopModel {
        newShop.name = shopNameTextField.text!
        newShop.address = shopAddressTextField.text!
        newShop.author = shopAuthorTextField.text!
        print("COORD", newShop.longitude, newShop.latitude)
        newShop.longitude = "\(27.5274070)"
        newShop.latitude = "\(53.9080890)"
        //COORD 27.5274065 53.9080877
        return newShop
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
            if let error = error {
                print("Error", error.message)
                strongSelf.showAlert(title: "Упс, ошибка!", message: "Попробуйте позже")
            } else if let response = response {
                print(response)
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
        configureMainView()
        configureSaveButton()
        configureViewController()
    }
    
    func configureViewController() {
        self.hideKeyboardWhenTappedAround()
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

