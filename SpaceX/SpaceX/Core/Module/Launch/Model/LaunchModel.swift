//
//  LaunchModel.swift
//  SpaceX
//
//  Created by Alexander Vagin on 22.07.2023.
//

import Foundation

// MARK: - Launch
struct Launch: Decodable {
    let name: String
    let dateUtc: String
    let success: Bool?
}

// MARK: - LaunchesResponse
struct LaunchesResponse: Decodable {
    let docs: [Launch]
}
