//
//  LaunchPresenter.swift
//  SpaceX
//
//  Created by Alexander Vagin on 20.07.2023.
//

import Foundation

protocol LaunchPresenterProtocol {
    init(view: LaunchVCProtocol, storageManager: StorageManagerProtocol)
}

final class LaunchPresenter: LaunchPresenterProtocol {
    
    weak var view: LaunchVCProtocol!
    unowned let storage: StorageManagerProtocol!
    
    init(view: LaunchVCProtocol, storageManager: StorageManagerProtocol) {
        self.view = view
        storage = storageManager
    }
    
}
