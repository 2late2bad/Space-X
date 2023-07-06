//
//  BasePresenter.swift
//  SpaceX
//
//  Created by Alexander Vagin on 06.07.2023.
//

import UIKit

protocol BasePresenterProtocol {
    init(view: BasePageProtocol,
         storageManager: StorageManagerProtocol,
         networkManager: NetworkManagerProtocol)
}

final class BasePresenter: BasePresenterProtocol {
    
    // MARK: - Properties
    weak var view: BasePageProtocol!
    unowned let storage: StorageManagerProtocol!
    let network: NetworkManagerProtocol!
    
    // MARK: - Init
    init(view: BasePageProtocol,
         storageManager: StorageManagerProtocol,
         networkManager: NetworkManagerProtocol) {
        self.view = view
        storage = storageManager
        network = networkManager
    }
}
