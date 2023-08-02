//
//  RootNavigationController.swift
//  SpaceX
//
//  Created by Alexander Vagin on 06.07.2023.
//

import UIKit

final class RootNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        checkFirstRunAppStatus()
    }
    
    override var prefersStatusBarHidden: Bool { true }
    
    override var modalPresentationCapturesStatusBarAppearance: Bool {
        get { true }
        set {}
    }

    private func configure() {
        let navBarAppearance = UINavigationBarAppearance()
        let buttonAppearance = UIBarButtonItemAppearance()
        
        let textAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: Colors.navigationBarTitle.uiColor, .font: Fonts.textRootNavBar.uiFont]
        
        navBarAppearance.titleTextAttributes = textAttributes
        buttonAppearance.normal.titleTextAttributes = textAttributes
        
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = Colors.backgroundNavigationBar.uiColor
        navBarAppearance.buttonAppearance = buttonAppearance
        
        navigationBar.tintColor = Colors.navigationBarTint.uiColor
        navigationBar.standardAppearance = navBarAppearance
        navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    private func checkFirstRunAppStatus() {
        guard let status = StorageManager.shared.bool(forKey: .firstLaunchApp),
                  status == true else { return }
        // Конфигурация приложения при первом запуске
        configureSettings()
        StorageManager.shared.set(false, forKey: .firstLaunchApp)
    }
    
    private func configureSettings() {
        var settings: [Setting] = []
        
        SettingType.allCases.forEach { type in
            settings.append(Setting(type: type, selectedIndex: 0))
        }
        
        StorageManager.shared.set(object: settings, forKey: .settings)
    }
}
