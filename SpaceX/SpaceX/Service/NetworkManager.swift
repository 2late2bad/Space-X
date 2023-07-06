//
//  NetworkManager.swift
//  SpaceX
//
//  Created by Alexander Vagin on 06.07.2023.
//

import Foundation

protocol NetworkManagerProtocol {
    
}

final class NetworkManager: NetworkManagerProtocol {
    
    // MARK: - Properties
    static let shared = NetworkManager()
    
    // MARK: - Init
    private init() {}
}
