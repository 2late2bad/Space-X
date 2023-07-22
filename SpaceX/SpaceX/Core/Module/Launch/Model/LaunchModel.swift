//
//  LaunchModel.swift
//  SpaceX
//
//  Created by Alexander Vagin on 22.07.2023.
//

import Foundation

struct Launch: Decodable {
    let name: String
    let dateUtc: String
    let success: Bool?
}

struct LaunchesResponse: Decodable {
    let docs: [Launch]
}
