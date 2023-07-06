//
//  AppDelegate.swift
//  SpaceX
//
//  Created by Alexander Vagin on 05.07.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    // MARK: - UIApplicationDelegate methods
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    { true }

    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication,
                     supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask
    { .portrait }
}
