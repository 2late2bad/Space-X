//
//  SettingModel.swift
//  SpaceX
//
//  Created by Alexander Vagin on 18.07.2023.
//

import Foundation

enum Unit: Codable {
    case meter
    case feet
    case kilogram
    case pound

    var name: String {
        switch self {
        case .feet:
            return "ft"
        case .meter:
            return "m"
        case .kilogram:
            return "kg"
        case .pound:
            return "lb"
        }
    }
}

enum SettingType: Codable, CaseIterable {
    case height
    case diameter
    case weight
    case payload
    
    var name: String {
        switch self {
        case .height:
            return "heigh_rocket".localized
        case .diameter:
            return "diameter".localized
        case .weight:
            return "mass_rocket".localized
        case .payload:
            return "payload_rocket".localized
        }
    }
    
    /// 0 index: европейская система мер
    /// 1 index: американская система мер
    var units: [Unit] {
        switch self {
        case .height, .diameter:
            return [.meter, .feet]
        case .weight, .payload:
            return [.kilogram, .pound]
        }
    }
}

struct Setting: Codable {
    let type: SettingType
    var selectedIndex: Int
}
