//
//  Fonts.swift
//  SpaceX
//
//  Created by Alexander Vagin on 07.07.2023.
//

import UIKit.UIFont

enum Fonts {
        
    case titleRocket
    case textRootNavBar
    case mainCollectionCellTitle
    case mainCollectionCellSubtitle
    case mainTextTableView
    case valueStageTextTableView
    case unitTextTableView
    case launchesButton
    case headerFooterTextView
    case closeButtonSettings
    case titleSettingVC
    case labelRowSettingVC
    case labelNameLaunchCell
    case labelDateLaunchCell
    case emptyLaunchesLabel
    case errorLabelEmptyScreen
    case errorMessageEmptyScreen
    
    // MARK: - Properties
    var uiFont: UIFont {
        switch self {
            
        case .titleRocket, .errorLabelEmptyScreen:
            return UIFont(name: "LabGrotesque-Medium", size: 24) ?? .systemFont(ofSize: 24, weight: .medium)
            
        case .textRootNavBar:
            return UIFont(name: "LabGrotesque-Medium", size: 16) ?? .systemFont(ofSize: 16, weight: .medium)
            
        case .mainCollectionCellTitle, .valueStageTextTableView, .unitTextTableView, .headerFooterTextView, .closeButtonSettings:
            return UIFont(name: "LabGrotesque-Bold", size: 16) ?? .systemFont(ofSize: 16, weight: .bold)
            
        case .launchesButton:
            return UIFont(name: "LabGrotesque-Bold", size: 18) ?? .systemFont(ofSize: 18, weight: .bold)
            
        case .labelNameLaunchCell, .emptyLaunchesLabel, .errorMessageEmptyScreen:
            return UIFont(name: "LabGrotesque-Regular", size: 20) ?? .systemFont(ofSize: 20, weight: .regular)
            
        case .mainTextTableView, .titleSettingVC, .labelRowSettingVC, .labelDateLaunchCell:
            return UIFont(name: "LabGrotesque-Regular", size: 16) ?? .systemFont(ofSize: 16, weight: .regular)
            
        case .mainCollectionCellSubtitle:
            return UIFont(name: "LabGrotesque-Regular", size: 14) ?? .systemFont(ofSize: 14, weight: .regular)
        }
    }
}
