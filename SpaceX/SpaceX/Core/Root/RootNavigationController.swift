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
    }
    
    override var prefersStatusBarHidden: Bool { true }
    
    override var modalPresentationCapturesStatusBarAppearance: Bool {
        get { true } set {}
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
}
