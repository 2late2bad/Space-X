//
//  MainPresenter.swift
//  SpaceX
//
//  Created by Alexander Vagin on 07.07.2023.
//

import Foundation

protocol MainPresenterProtocol {
    init(view: MainVCProtocol, storageManager: StorageManagerProtocol)
    func getDataRockets(numbRocket: Int)
}

final class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainVCProtocol!
    unowned let storage: StorageManagerProtocol!
    var rocket: Rocket?
    
    init(view: MainVCProtocol, storageManager: StorageManagerProtocol) {
        self.view = view
        storage = storageManager
    }
    
    func getDataRockets(numbRocket: Int) {
        guard let data: [RocketModel] = storage.decodableData(forKey: .rockets) else {
            view.failure()
            return
        }
        
        let actRocket = data[numbRocket - 1]
        
        rocket = Rocket(id: actRocket.id,
                        name: actRocket.name)
        
        view.success(rocket: rocket!)
    }
}
