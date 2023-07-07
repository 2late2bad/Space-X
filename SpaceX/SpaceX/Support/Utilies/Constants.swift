//
//  Constants.swift
//  SpaceX
//
//  Created by Alexander Vagin on 06.07.2023.
//

import Foundation

typealias C = Constants

enum Constants {
    
    enum Padding {
        static let additionalSafeAreaInsetsBottom: CGFloat = 12
        static let additionalPageControlHeight: CGFloat = 26
    }
    
    enum API {
        static let rockets = "https://api.spacexdata.com/v4/rockets"
        static let launches = "https://api.spacexdata.com/v4/launches"
    }
}
