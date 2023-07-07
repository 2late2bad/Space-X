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
    func loadPages()
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
    func loadPages() {
        guard let url = URL(string: C.API.rockets) else {
            self.view.failure(error: NetworkError.invalidURL)
            return
        }
        network.request(fromURL: url, httpMethod: .get) { (result: Result<[Rocket], NetworkError>) in
            switch result {
            case .success(let rockets):
                self.view.success(withNumber: rockets.count)
            case .failure(let error):
                self.view.failure(error: error)
            }
        }
    }
}
