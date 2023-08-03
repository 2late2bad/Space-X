//
//  StorageManager.swift
//  SpaceX
//
//  Created by Alexander Vagin on 06.07.2023.
//

import Foundation

protocol StorageManagerProtocol: AnyObject {
    // Запись
    func set(_ object: Any?, forKey key: StorageKeys)
    func set<T: Encodable>(object: T?, forKey key: StorageKeys)
    func append<T: Codable>(object: T, forKey key: StorageKeys)
    // Чтение
    func int(forKey key: StorageKeys) -> Int?
    func string(forKey key: StorageKeys) -> String?
    func dict(forKey key: StorageKeys) -> [String: Any]?
    func date(forKey key: StorageKeys) -> Date?
    func bool(forKey key: StorageKeys) -> Bool?
    func data(forKey key: StorageKeys) -> Data?
    func decodableData<T: Decodable>(forKey key: StorageKeys) -> T?
}

final class StorageManager {
    
    // MARK: - Properties
    static let shared = StorageManager()
    private let userDefaults = UserDefaults.standard
    
    // MARK: - Init
    private init() {}
    
    // MARK: - Private methods
    private func store(_ object: Any?, key: String) {
        userDefaults.set(object, forKey: key)
    }
    
    private func restore(for key: String) -> Any? {
        userDefaults.object(forKey: key)
    }
}

// MARK: - StorageManagerProtocol Impl
extension StorageManager: StorageManagerProtocol {
    
    func set(_ object: Any?, forKey key: StorageKeys) {
        store(object, key: key.rawValue)
    }
    
    func set<T: Encodable>(object: T?, forKey key: StorageKeys) {
        let jsonData = try? JSONEncoder().encode(object)
        store(jsonData, key: key.rawValue)
    }
    
    func append<T: Codable>(object: T, forKey key: StorageKeys) {
        if var array: [T] = decodableData(forKey: key) {
            array.append(object)
            set(object: array, forKey: key)
        } else {
            let newArray: [T] = [object]
            set(object: newArray, forKey: key)
        }
    }
    
    func int(forKey key: StorageKeys) -> Int? {
        restore(for: key.rawValue) as? Int
    }
    
    func string(forKey key: StorageKeys) -> String? {
        restore(for: key.rawValue) as? String
    }
    
    func dict(forKey key: StorageKeys) -> [String : Any]? {
        restore(for: key.rawValue) as? [String : Any]
    }
    
    func date(forKey key: StorageKeys) -> Date? {
        restore(for: key.rawValue) as? Date
    }
    
    func bool(forKey key: StorageKeys) -> Bool? {
        restore(for: key.rawValue) as? Bool
    }
    
    func data(forKey key: StorageKeys) -> Data? {
        restore(for: key.rawValue) as? Data
    }
    
    func decodableData<T: Decodable>(forKey key: StorageKeys) -> T? {
        guard let data = restore(for: key.rawValue) as? Data else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
    
    func remove(forKey key: StorageKeys) {
        userDefaults.removeObject(forKey: key.rawValue)
    }
}
