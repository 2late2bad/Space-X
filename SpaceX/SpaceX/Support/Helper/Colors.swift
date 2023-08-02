//
//  Colors.swift
//  SpaceX
//
//  Created by Alexander Vagin on 06.07.2023.
//

import UIKit.UIColor

enum Colors {
    
    // Root Navigation Controller
    case navigationBarTitle
    case navigationBarTint
    case backgroundNavigationBar
    
    // Page view
    case pageIndicator
    case currentPageIndicator
    case backgroundPageView
    
    // MainVC
    case backgroundMainVC
    case backgroundRocketImage
    case activityIndicator
    
    // Main content view
    case backgroundContentView
    case titleRocket
    case settingsButton
    
    // Main collection view
    case backgroundCollectionCell
    case titleCollectionCell
    case subtitleCollectionCell
    
    // Main table view
    case backgroundTableView
    case mainTextTableView
    case valueTextTableView
    case unitTextTableView
    case headerFooterTextTableView
    
    // Footer button
    case backgroundFooterButton
    case titleFooterButton
    
    // Settings screen
    case backgroundSettingVC
    case closeButtonSettingVC
    case titleSettingVC
    case labelRowSettingVC
    case backgroundSegmentControl
    case selectedSegmentTintColor
    case segmentedNormalText
    case segmentedSelectedText
    
    // Launch screen
    case backgroundLaunchVC
    case backgroundViewLaunchCell
    case nameLaunchLabel
    case dateLaunchLabel
    case tintStatusImageView
    case emptyLaunchesLabel
    
    // Empty screen
    case errorLabelEmptyScreen
    
    var uiColor: UIColor {
        switch self {
        case .currentPageIndicator, .titleCollectionCell, .closeButtonSettingVC, .titleSettingVC, .selectedSegmentTintColor, .activityIndicator, .nameLaunchLabel, .emptyLaunchesLabel:
            return hexStringToUIColor(hex: "#FFFFFF")
            
        case .backgroundContentView, .backgroundMainVC, .backgroundTableView, .backgroundLaunchVC, .backgroundNavigationBar, .errorLabelEmptyScreen:
            return hexStringToUIColor(hex: "#000000")
            
        case .backgroundCollectionCell, .backgroundFooterButton, .backgroundSegmentControl, .backgroundViewLaunchCell:
            return hexStringToUIColor(hex: "#212121")
            
        case .titleRocket, .settingsButton, .valueTextTableView, .titleFooterButton, .headerFooterTextTableView, .labelRowSettingVC, .navigationBarTitle, .navigationBarTint:
            return hexStringToUIColor(hex: "#F6F6F6")
            
        case .mainTextTableView:
            return hexStringToUIColor(hex: "#CACACA")
            
        case .pageIndicator, .subtitleCollectionCell, .unitTextTableView, .segmentedNormalText, .dateLaunchLabel, .tintStatusImageView:
            return hexStringToUIColor(hex: "#8E8E8F")
            
        case .backgroundPageView, .backgroundSettingVC, .segmentedSelectedText, .backgroundRocketImage:
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
