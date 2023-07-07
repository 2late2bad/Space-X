//
//  StorageManager.swift
//  SpaceX
//
//  Created by Alexander Vagin on 06.07.2023.
//

import Foundation

protocol StorageManagerProtocol: AnyObject {
    // Запись
    func set(_ object: Any?, forKey key: C.StorageKeys)
    func set<T: Encodable>(object: T?, forKey key: C.StorageKeys)
    // Чтение
    func int(forKey key: C.StorageKeys) -> Int?
    func string(forKey key: C.StorageKeys) -> String?
    func dict(forKey key: C.StorageKeys) -> [String: Any]?
    func date(forKey key: C.StorageKeys) -> Date?
    func bool(forKey key: C.StorageKeys) -> Bool?
    func data(forKey key: C.StorageKeys) -> Data?
    func decodableData<T: Decodable>(forKey key: C.StorageKeys) -> T?
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

extension StorageManager: StorageManagerProtocol {
    
    func set(_ object: Any?, forKey key: C.StorageKeys) {
        store(object, key: key.rawValue)
    }
    
    func set<T: Encodable>(object: T?, forKey key: C.StorageKeys) {
        let jsonData = try? JSONEncoder().encode(object)
        store(jsonData, key: key.rawValue)
    }
    
    func int(forKey key: C.StorageKeys) -> Int? {
        restore(for: key.rawValue) as? Int
    }
    
    func string(forKey key: C.StorageKeys) -> String? {
        restore(for: key.rawValue) as? String
    }
    
    func dict(forKey key: C.StorageKeys) -> [String : Any]? {
        restore(for: key.rawValue) as? [String : Any]
    }
    
    func date(forKey key: C.StorageKeys) -> Date? {
        restore(for: key.rawValue) as? Date
    }
    
    func bool(forKey key: C.StorageKeys) -> Bool? {
        restore(for: key.rawValue) as? Bool
    }
    
    func data(forKey key: C.StorageKeys) -> Data? {
        restore(for: key.rawValue) as? Data
    }
    
    func decodableData<T: Decodable>(forKey key: C.StorageKeys) -> T? {
        guard let data = restore(for: key.rawValue) as? Data else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
    
    func remove(forKey key: C.StorageKeys) {
        userDefaults.removeObject(forKey: key.rawValue)
    }
}
