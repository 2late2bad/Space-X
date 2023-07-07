//
//  Colors.swift
//  SpaceX
//
//  Created by Alexander Vagin on 06.07.2023.
//

import UIKit.UIColor

enum Colors {
    
    case pageIndicator
    case currentPageIndicator
    case backgroundPageView
    
    var uiColor: UIColor {
        switch self {
        case .currentPageIndicator:
            return hexStringToUIColor(hex: "#FFFFFF")
            
        case .pageIndicator:
            return hexStringToUIColor(hex: "#8E8E8F")
            
        case .backgroundPageView:
            return hexStringToUIColor(hex: "#121212")
        }
    }
}

fileprivate extension Colors {
    
    func hexStringToUIColor(hex: String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
