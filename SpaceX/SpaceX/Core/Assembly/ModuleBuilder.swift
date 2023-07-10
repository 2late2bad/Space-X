//
//  ModuleBuilder.swift
//  SpaceX
//
//  Created by Alexander Vagin on 06.07.2023.
//

import UIKit

protocol ModuleBuilderProtocol {
    func createBaseModule(router: RocketRouterProtocol) -> UIViewController
    func createMainModule(with pageNumb: Int, router: RocketRouterProtocol) -> MainVC
    func createSettingModule(router: RocketRouterProtocol) -> UIViewController
    func createEmpty(errorText: String, router: RocketRouterProtocol) -> UIViewController}

final class ModuleBuilder {
    
    // MARK: - Properties
    let networkManager = NetworkManager.shared
    let storageManager = StorageManager.shared
}

// MARK: - Implementation ModuleBuilderProtocol

extension ModuleBuilder: ModuleBuilderProtocol {
    
    func createBaseModule(router: RocketRouterProtocol) -> UIViewController {
        
        let view      = BasePageVC(transitionStyle: .scroll,
                                   navigationOrientation: .horizontal)
        let presenter = BasePresenter(view: view,
                                      storageManager: storageManager,
                                      networkManager: networkManager)
        
        view.router = router
        view.presenter = presenter
        
        return view
    }
    
    func createMainModule(with pageNumb: Int, router: RocketRouterProtocol) -> MainVC {
        
        let view      = MainVC()
        let presenter = MainPresenter(view: view,
                                      storageManager: storageManager)
        view.router = router
        view.presenter = presenter
        view.pageNumb = pageNumb
        
        return view
    }
    
    func createSettingModule(router: RocketRouterProtocol) -> UIViewController {
        
        let view      = SettingVC()
        let presenter = SettingPresenter(view: view,
                                         storageManager: storageManager)
        view.router = router
        view.presenter = presenter
        
        return view
    }
    
    func createEmpty(errorText: String, router: RocketRouterProtocol) -> UIViewController {
        let view = EmptyVC(errorText: errorText)
        view.router = router
        return view
    }
}
