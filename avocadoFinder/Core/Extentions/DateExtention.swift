//
//  DateExtention.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 7/11/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import Foundation

extension Date {
    
    func dateToStringDMY() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    func dateToStringTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    static func stringToDate(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.date(from: dateString)
    }
    
}
