//
//  Settings.swift
//  SpaceX
//
//  Created by Alexander Vagin on 05.07.2023.
//

import Foundation

enum Unit {
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

enum SettingType: Codable {
    case height
    case diameter
    case weight
    case payload
    
    var name: String {
        switch self {
        case .height:
            return "Высота"
        case .diameter:
            return "Диаметр"
        case .weight:
            return "Масса"
        case .payload:
            return "Полезная нагрузка"
        }
    }
    
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
    let selectedIndex: Int
}
