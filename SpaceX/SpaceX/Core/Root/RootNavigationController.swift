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
    
    private func configure() {
        let textAttributes = [NSAttributedString.Key.foregroundColor: Colors.navigationBarTitle.uiColor]
        navigationBar.titleTextAttributes = textAttributes
        navigationBar.tintColor = Colors.navigationBarTint.uiColor
    }
}
