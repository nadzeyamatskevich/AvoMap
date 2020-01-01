//
//  ServerAuthorizedHeaders.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 6/15/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

var ServerAuthorizedHeaders: [String: String] {
    var params = [String : String]()
    params["Content-Type"] = "application/json"
    params["Authorization"] = "Basic ios-0x9lGNc"
    return params
}
