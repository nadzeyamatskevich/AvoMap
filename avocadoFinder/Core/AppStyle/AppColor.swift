//
//  AppFont.swift
//  avocadoFinder
//
//  Created by Nadzeya Savitskaya on 5/2/19.
//  Copyright © 2019 Nadzeya Savitskaya. All rights reserved.
//

import UIKit

enum AppColor {
    
    static let cyan = color(fromHex: "4cc1c7")
    static let darkCyan = color(fromHex: "3bbab6")
    static let green = color(fromHex: "abdc90")
    
    static let grayTabBar = UIColor(red: 144/255, green: 144/255, blue: 144/255, alpha: 1)
    
    static func black(alpha: CGFloat = 1.0) -> UIColor {
        return color(fromHex: "000000", alpha: alpha)
    }
    
    static func white(alpha: CGFloat = 1.0) -> UIColor {
        return color(fromHex: "ffffff", alpha: alpha)
    }
    
}

// MARK: -
// MARK: - Calc color

fileprivate extension AppColor {
    
    private static func color(fromHex hex: String, alpha: CGFloat = 1.0) -> UIColor {
        let cString: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines as CharacterSet).uppercased()
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
}
