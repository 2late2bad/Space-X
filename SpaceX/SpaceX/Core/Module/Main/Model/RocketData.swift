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
    let image: UIImage
    let name: String
    let height, diameter, mass, payloadWeight: Parameter
    let firstFlight, country: String
    let costPerLaunch: Int
    let firstStage, secondStage: Stage
    
    // MARK: - Parameter
    struct Parameter {
        let value: String
        let unit: String
    }
    
    // MARK: - Stage
    struct Stage {
        let engines: Int
        let fuelAmountTons: Double
        let burnTimeSec: Int?
    }
}
