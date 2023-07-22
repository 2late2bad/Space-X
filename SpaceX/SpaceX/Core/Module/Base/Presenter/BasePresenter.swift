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
    func getPages()
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
    
    // MARK: - Protocol methods
    func getPages() {
        if let data: [RocketModel] = storage.decodableData(forKey: .rockets) {
            view.success(with: data)
        } else {
            loadPages()
        }
    }
    
    private func loadPages() {
        network.request(from: C.API.rockets,
                           httpMethod: .get, requestBody: nil) { (result: Result<[RocketModel], NetworkError>) in
            switch result {
            case .success(let rockets):
                self.storage.set(object: rockets, forKey: .rockets)
                self.view.success(with: rockets)
            case .failure(let error):
                self.view.failure(error: error)
            }
        }
    }
}
