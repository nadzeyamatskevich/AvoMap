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
        return UTCToLocal(date: dateString, format: "dd.MM.yyyy")
    }
    
    func dateToStringTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let dateString = dateFormatter.string(from: self)
        return UTCToLocal(date: dateString, format: "HH:mm")
    }
    
    func dateToStringTimeDMY() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm dd.MM.yyyy"
        let dateString = dateFormatter.string(from: self)
        return UTCToLocal(date: dateString, format: "HH:mm dd.MM.yyyy")
    }
    
    static func stringToDate(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.date(from: dateString)
    }
    
    func UTCToLocal(date: String, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = format

        return dateFormatter.string(from: dt!)
    }

}
