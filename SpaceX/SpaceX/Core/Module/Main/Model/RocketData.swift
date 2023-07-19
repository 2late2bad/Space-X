//
//  RocketData.swift
//  SpaceX
//
//  Created by Alexander Vagin on 07.07.2023.
//

import UIKit

typealias Rocket = RocketData

// MARK: - RocketData
struct RocketData {
    let id: String
    let images: [String]
    // Header
    let name: String
    // Collection view
    let features: [Feature]
    // Table view
    let firstFlight: String
    let country: String
    let costPerLaunch: Int
    let firstStage: Stage
    let secondStage: Stage
}

extension RocketData {
    struct Stage {
        let engines: Int
        let fuelAmountTons: Double
        let burnTimeSec: Int?
    }
}

// -> ??
enum UnitSettingType {
    case length(meters: Double, feet: Double)
    case weight(kg: Double, lb: Double)
    
    var description: (eu: String, us: String) {
        switch self {
        case .length:
            return ("m", "ft")
        case .weight:
            return ("kg", "lb")
        }
    }
}

struct Feature {
    let type: UnitSettingType
    let name: String
    
    var value: String {
        switch type {
        case .length(let meters, _):
            return String(meters)
        case .weight(let kg, _):
            return String(kg)
        }
    }
}



//
//enum Unit {
//    case meter
//    case feet
//    case kilogram
//    case pound
//    
//    var name: String {
//        switch self {
//        case .feet:
//            return "ft"
//        case .meter:
//            return "m"
//        case .kilogram:
//            return "kg"
//        case .pound:
//            return "lb"
//        }
//    }
//}
//
//enum SettingType: Encodable {
//    case height
//    case diameter
//    case weight
//    case payload
//    
//    var name: String {
//        switch self {
//        case .height:
//            return "Высота"
//        case .diameter:
//            return "Диаметр"
//        case .weight:
//            return "Масса"
//        case .payload:
//            return "Нагрузка"
//        }
//    }
//    
//    var units: [Unit] {
//        switch self {
//        case .height, .diameter:
//            return [.meter, .feet]
//        case .weight, .payload:
//            return [.kilogram, .pound]
//        }
//    }
//}
//
//struct Setting: Encodable {
//    let type: SettingType
//    let selectedIndex: Int
//}
