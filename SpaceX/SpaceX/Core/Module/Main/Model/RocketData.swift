//
//  RocketData.swift
//  SpaceX
//
//  Created by Alexander Vagin on 07.07.2023.
//

import UIKit

typealias Rocket = RocketData

// MARK: - RocketData
struct RocketData: Codable {
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
    struct Stage: Codable {
        let engines: Int
        let fuelAmountTons: Double
        let burnTimeSec: Int?
    }
}

// -> ??
enum UnitSettingType: Codable, Hashable {
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

struct Feature: Codable, Hashable {
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

