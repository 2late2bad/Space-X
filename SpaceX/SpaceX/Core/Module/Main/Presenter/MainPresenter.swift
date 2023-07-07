//
//  MainPresenter.swift
//  SpaceX
//
//  Created by Alexander Vagin on 07.07.2023.
//

import Foundation

protocol MainPresenterProtocol {
    init(view: MainVCProtocol, storageManager: StorageManagerProtocol)
}

final class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainVCProtocol!
    unowned let storage: StorageManagerProtocol!
    
    init(view: MainVCProtocol, storageManager: StorageManagerProtocol) {
        self.view = view
        storage = storageManager
    }
}
