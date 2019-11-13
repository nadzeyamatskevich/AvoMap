//
//  SettingsCellConfigurator.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 7/13/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

class SettingsCellConfigurator {
    
    // - Data
    private var cells = [SettingsCellViewModel]()
    
    // - Configure
    func configure() -> [SettingsCellViewModel] {
        
        addAuthorCell(value: AppAuthors.minina.rawValue)
        addAuthorCell(value: AppAuthors.nadzeyasavitskaya.rawValue)
        addAuthorCell(value: AppAuthors.yanaPoddubskaya.rawValue)
        addAuthorCell(value: AppAuthors.katyarunkevich.rawValue)
        addAuthorCell(value: AppAuthors.antonsavicky.rawValue)
        addInfoCell(value: AppDocuments.privacyPolicy.rawValue)
        addInfoCell(value: AppDocuments.termsAndCondition.rawValue)
        
        return cells
    }
    
    func addAuthorCell(value: String) {
        let authorCellModel = SettingsCellViewModel(type: .author, value: value)
        cells.append(authorCellModel)
    }
    
    func addInfoCell(value: String) {
        let infoCellModel = SettingsCellViewModel(type: .info, value: value)
        cells.append(infoCellModel)
    }
    
}
