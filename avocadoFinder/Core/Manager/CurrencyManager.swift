//
//  CurrencyManager.swift
//  avocadoFinder
//
//  Created by Nick Poe on 2/8/20.
//  Copyright © 2020 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class CurrencyModel {
    
    private(set) var name = ""
    private(set) var currency = ""
    
    init(name: Any, currency: Any) {
        self.name = name as! String
        self.currency = currency as! String
    }
    
}

final class CurrencyManager: NSObject {
    
    static let shared = CurrencyManager()

    private override init() {}
    
    // - Data
    private let countryCodesOfEuropean = ["BE", "EL", "LT", "PT", "BG", "ES", "LU", "RO", "CZ", "FR", "HU", "SI", "DK", "HR", "MT", "SK", "DE", "IT", "NL", "FI", "EE", "CY", "AT", "SE", "IE", "LV", "PL"]
    
    var currencies: [CurrencyModel] {
        var currencies = [CurrencyModel]()
        let bundle = Bundle.main
        let jsonPath = bundle.path(forResource: "currencies", ofType: "json") ?? ""
        
        guard let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonPath)) else { return []}
        do {
            if let jsonObjects = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? NSArray {
                for jsonObject in jsonObjects {
                    
                    guard let countryObj = jsonObject as? NSDictionary else {
                        return currencies
                    }
                    countryObj.forEach({currencies.append(CurrencyModel(name: $0.value, currency: $0.key))})
                }
                return currencies
            }
        } catch {
            return []
        }
        return []
    }
    
    var selectedСurrency: String {
        let selectedСurrency = UserDefaultsManager.shared.get(data: .selectedСurrency)
        
        print("selectedСurrency -> \(selectedСurrency)")
        if selectedСurrency.isEmpty == false {
            print("-> return selectedСurrency")
            return selectedСurrency
        }
        let regionCode = getRegionCode()
        if countryCodesOfEuropean.contains(regionCode) {
            return "EUR"
        } else if regionCode == "BY" {
            return "BYR"
        } else if regionCode == "RU"{
            return "RUB"
        } else if regionCode == "UA" {
            return "UAH"
        } else {
            return "USD"
        }
    }
    
    func getRegionCode() -> String {
      let locale = Locale.current
      guard let regionCode = locale.regionCode else { return "DE" }
      return regionCode
    }
}
