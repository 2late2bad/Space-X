//
//  SettingPresenter.swift
//  SpaceX
//
//  Created by Alexander Vagin on 10.07.2023.
//

import Foundation

protocol SettingPresenterProtocol {
    init(view: SettingVCProtocol, storageManager: StorageManagerProtocol)
}

final class SettingPresenter: SettingPresenterProtocol {
    
    weak var view: SettingVCProtocol!
    unowned let storage: StorageManagerProtocol!
    
    init(view: SettingVCProtocol, storageManager: StorageManagerProtocol) {
        self.view = view
        storage = storageManager
    }
}
