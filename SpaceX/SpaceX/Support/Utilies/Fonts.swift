//
//  Fonts.swift
//  SpaceX
//
//  Created by Alexander Vagin on 07.07.2023.
//

import UIKit.UIFont

enum Fonts {
    
    private enum Style: String {
        case thin       = "Thin"
        case regular    = "Regular"
        case medium     = "Medium"
        case bold       = "Bold"
    }
    
    case titleRocket
    
    // MARK: - Properties
    var uiFont: UIFont {
        switch self {
            
        case .titleRocket:
            return UIFont(name: "LabGrotesque-Medium", size: 24)!
            
        }
    }
    
}
