//
//  Constants.swift
//  SpaceX
//
//  Created by Alexander Vagin on 06.07.2023.
//

import Foundation

typealias C = Constants

enum Constants {
    
    typealias Callback = () -> Void
    
    enum API {
        static let rockets = "https://api.spacexdata.com/v4/rockets"
        static let launches = "https://api.spacexdata.com/v4/launches"
    }
    
    enum DateFormat: String {
        case server = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        case fullYearMonthDay = "yyyy-MM-dd"
    }
}
