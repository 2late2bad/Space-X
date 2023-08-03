//
//  LaunchPresenter.swift
//  SpaceX
//
//  Created by Alexander Vagin on 20.07.2023.
//

import Foundation

protocol LaunchPresenterProtocol {
    init(view: LaunchVCProtocol,
         storageManager: StorageManagerProtocol,
         networkManager: NetworkManagerProtocol)
    func getAllRocketLaunches(for rocketID: String)
}

final class LaunchPresenter: LaunchPresenterProtocol {
    
    // MARK: - Properties
    weak var view: LaunchVCProtocol!
    unowned let storage: StorageManagerProtocol!
    let network: NetworkManagerProtocol!
    
    // MARK: - Init
    init(view: LaunchVCProtocol, storageManager: StorageManagerProtocol, networkManager: NetworkManagerProtocol) {
        self.view = view
        storage = storageManager
        network = networkManager
    }
    
    // MARK: - LaunchPresenterProtocol Impl
    func getAllRocketLaunches(for rocketID: String) {
        let urlString = C.API.launches + "/query"
        
        let requestBody: [String: Any] = [
            "query": [
                "rocket": rocketID
            ],
            "options": [
                "pagination": false
            ]
        ]
        
        network.request(from: urlString,
                        httpMethod: .post,
                        requestBody: requestBody) { (result: Result<LaunchesResponse, NetworkError>) in
            switch result {
            case .success(let launchesResponse):
                let sortedArray = launchesResponse.docs.sorted { $0.dateUtc > $1.dateUtc }
                self.view.success(with: sortedArray)
            case .failure(let error):
                self.view.failure(error: error)
            }
        }
    }
}
