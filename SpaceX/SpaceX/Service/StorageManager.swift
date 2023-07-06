//
//  StorageManager.swift
//  SpaceX
//
//  Created by Alexander Vagin on 06.07.2023.
//

import Foundation

protocol StorageManagerProtocol: AnyObject {
    
}

final class StorageManager: StorageManagerProtocol {
    
    // MARK: - Properties
    static let shared = StorageManager()
    
    // MARK: - Init
    private init() {}
}
