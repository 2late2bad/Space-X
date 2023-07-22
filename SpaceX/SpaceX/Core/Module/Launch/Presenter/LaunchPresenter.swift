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
//    func fetchAllRocketLaunches(forRocketID rocketID: String,
//                                completion: @escaping (Result<[Launch], NetworkError>) -> Void)
    func getAllRocketLaunches(for rocketID: String)
}

final class LaunchPresenter: LaunchPresenterProtocol {
    
    weak var view: LaunchVCProtocol!
    unowned let storage: StorageManagerProtocol!
    let network: NetworkManagerProtocol!
    
    init(view: LaunchVCProtocol, storageManager: StorageManagerProtocol, networkManager: NetworkManagerProtocol) {
        self.view = view
        storage = storageManager
        network = networkManager
    }
    
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
                self.view.success(with: launchesResponse.docs)
                //completion(.success(launchesResponse.docs))
            case .failure(let error):
                self.view.failure(error: error)
                //completion(.failure(error))
            }
        }
    }

    
    func fetchAllRocketLaunches(forRocketID rocketID: String,
                                completion: @escaping (Result<[Launch], NetworkError>) -> Void) {
        
        let urlString = C.API.launches + "/query"
        
        let requestBody: [String: Any] = [
            "query": [
                "rocket": rocketID
            ],
            "options": [
                "pagination": false
            ]
        ]
        
        network.request(from: urlString, httpMethod: .post, requestBody: requestBody) { (result: Result<LaunchesResponse, NetworkError>) in
            switch result {
            case .success(let launchesResponse):
                completion(.success(launchesResponse.docs))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
