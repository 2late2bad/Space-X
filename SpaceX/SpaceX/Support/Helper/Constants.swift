//
//  Constants.swift
//  SpaceX
//
//  Created by Alexander Vagin on 06.07.2023.
//

import Foundation

typealias C = Constants
typealias Callback = () -> Void

enum Constants {
    
    enum API {
        static let rockets = "https://api.spacexdata.com/v4/rockets"
        static let launches = "https://api.spacexdata.com/v4/launches"
    }
    
    public enum StorageKeys: String {
        case rockets
        case launches
    }
}
