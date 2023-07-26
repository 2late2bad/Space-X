//
//  RocketData.swift
//  SpaceX
//
//  Created by Alexander Vagin on 07.07.2023.
//

import UIKit

typealias Rocket = RocketData
typealias Feature = RocketFeature

// MARK: - RocketData
struct RocketData {
    let id: String
    // Image view
    let images: [String]
    // Header
    let name: String
    // Table view
    let firstFlight: String
    let country: String
    let costPerLaunch: Int
    let firstStage: Stage
    let secondStage: Stage
}

// Collection view
struct RocketFeature {
    let values: (eu: Double, us: Double)
    let setting: Setting
    
    var value: Double {
        setting.selectedIndex == 0 ? values.eu : values.us
    }
}

extension RocketData {
    
    struct Stage {
        let engines: Int
        let fuelAmountTons: Double
        let burnTimeSec: Int?
    }
}
