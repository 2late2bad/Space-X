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
    func routeMainModule(with rocket: RocketModel) -> MainVC
    func routeSettingModule(delegate: SettingVCDelegate)
    func routeLaunchModule(with id: String, title rocketTitle: String)
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
    
    func routeMainModule(with rocket: RocketModel) -> MainVC {
        moduleBuilder.createMainModule(with: rocket, router: self)
    }
    
    func routeSettingModule(delegate: SettingVCDelegate) {
        let settingVC = moduleBuilder.createSettingModule(router: self, delegate: delegate)
        let navCon = UINavigationController(rootViewController: settingVC)
        navigationController.present(navCon, animated: true)
    }
    
    func routeLaunchModule(with id: String, title rocketTitle: String) {
        let launchVC = moduleBuilder.createLaunchModule(with: id, router: self)
        launchVC.title = rocketTitle
        navigationController.pushViewController(launchVC, animated: true)
    }
    
    func routeEmpty(errorText: String) -> UIViewController {
        moduleBuilder.createEmpty(errorText: errorText, router: self)
    }
}
