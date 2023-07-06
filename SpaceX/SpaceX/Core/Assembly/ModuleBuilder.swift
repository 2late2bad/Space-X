//
//  ModuleBuilder.swift
//  SpaceX
//
//  Created by Alexander Vagin on 06.07.2023.
//

import UIKit

protocol ModuleBuilderProtocol {
    func createBaseModule(router: RocketRouterProtocol) -> UIPageViewController
}

final class ModuleBuilder {
    
    // MARK: - Properties
    let networkManager = NetworkManager.shared
    let storageManager = StorageManager.shared
}

// MARK: - Implementation ModuleBuilderProtocol

extension ModuleBuilder: ModuleBuilderProtocol {
    
    func createBaseModule(router: RocketRouterProtocol) -> UIPageViewController {
        
        let view = BasePageVC(transitionStyle: .scroll,
                              navigationOrientation: .horizontal)
        let presenter = BasePresenter(view: view,
                                      storageManager: storageManager,
                                      networkManager: networkManager)
        
        view.router = router
        view.presenter = presenter
        
        return view
    }
}
