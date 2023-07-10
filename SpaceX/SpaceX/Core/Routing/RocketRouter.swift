//
//  MainRouter.swift
//  SpaceX
//
//  Created by Alexander Vagin on 06.07.2023.
//

import UIKit

protocol RocketRouterProtocol: RouterProtocol {
    func routeBaseModule()
    func routeEmpty(errorText: String) -> UIViewController
    func routeMainModule(with pageNumber: Int) -> MainVC
    func routeSettingModule()
}

final class RocketRouter {
   
    // MARK: - Properties
    let navigationController: UINavigationController!
    let moduleBuilder: ModuleBuilderProtocol!
    
    // MARK: - Init
    init(navigationController: UINavigationController,
         moduleBuilder: ModuleBuilderProtocol) {
        self.navigationController = navigationController
        self.moduleBuilder = moduleBuilder
    }
}

// MARK: - Implementation RocketRouterProtocol

extension RocketRouter: RocketRouterProtocol {
    
    // MARK: - Methods
    func routeBaseModule() {
        let baseView = moduleBuilder.createBaseModule(router: self)
        navigationController.viewControllers = [baseView]
    }
    
    func routeMainModule(with pageNumber: Int) -> MainVC {
        moduleBuilder.createMainModule(with: pageNumber, router: self)
    }
    
    func routeSettingModule() {
        let settingVC = moduleBuilder.createSettingModule(router: self)
        let navCon = UINavigationController(rootViewController: settingVC)
        navigationController.present(navCon, animated: true)
    }
    
    func routeEmpty(errorText: String) -> UIViewController {
        moduleBuilder.createEmpty(errorText: errorText, router: self)
    }
}
