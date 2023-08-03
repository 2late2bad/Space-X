//
//  SceneDelegate.swift
//  SpaceX
//
//  Created by Alexander Vagin on 05.07.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - Properties
    var window: UIWindow?

    // MARK: - UIWindowSceneDelegate methods
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let root = RootNavigationController()
        let builder = ModuleBuilder()
        let router = RocketRouter(navigationController: root,
                                  moduleBuilder: builder)
        router.routeBaseModule()
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = root
        window?.makeKeyAndVisible()
    }
}
