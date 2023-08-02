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
    func updateSegment(selected index: Int, indexItem: Int)
}

final class SettingPresenter: SettingPresenterProtocol {
    
    weak var view: SettingVCProtocol!
    unowned let storage: StorageManagerProtocol!
    
    var settings: [Setting]! {
        willSet {
            storage.set(object: newValue, forKey: .settings)
        }
    }
    
    init(view: SettingVCProtocol, storageManager: StorageManagerProtocol) {
        self.view = view
        storage = storageManager
    }
    
    func updateSegment(selected index: Int, indexItem: Int) {
        settings[indexItem].selectedIndex = index
        view.postNotification(name: .updateSettings, object: nil)
    }
}
