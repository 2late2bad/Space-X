//
//  SettingPresenter.swift
//  SpaceX
//
//  Created by Alexander Vagin on 10.07.2023.
//

import Foundation

protocol SettingPresenterProtocol {
    init(view: SettingVCProtocol, storageManager: StorageManagerProtocol)
    var settings: [Setting]! { get set }
    func loadSettins()
    func updateSegment(selected index: Int, indexItem: Int)
}

final class SettingPresenter: SettingPresenterProtocol {
    
    // MARK: - Properties
    weak var view: SettingVCProtocol!
    unowned let storage: StorageManagerProtocol!
    var settings: [Setting]!
    
    // MARK: - Init
    init(view: SettingVCProtocol, storageManager: StorageManagerProtocol) {
        self.view = view
        storage = storageManager
    }
    
    // MARK: - SettingPresenterProtocol Impl
    func loadSettins() {
        if let settings: [Setting] = storage.decodableData(forKey: .settings) {
            self.settings = settings
        } else {
            self.settings = []
            view.failureLoadSettings()
        }
    }
    
    func updateSegment(selected index: Int, indexItem: Int) {
        settings[indexItem].selectedIndex = index
        storage.set(object: settings, forKey: .settings)
        view.postNotification(name: .updateSettings, object: nil)
    }
}
