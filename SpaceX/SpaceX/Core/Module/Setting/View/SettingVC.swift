//
//  SettingVC.swift
//  SpaceX
//
//  Created by Alexander Vagin on 10.07.2023.
//

import UIKit

protocol SettingVCProtocol: AnyObject {
    
}

final class SettingVC: UIViewController {
    
    private enum LocalConstant {
        static let title: String = "Настройки"
        static let buttonTitle: String = "Закрыть"
    }
    
    var router: RocketRouterProtocol!
    var presenter: SettingPresenterProtocol!
    
    private let settingStack = SettingStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNavBar()
        layoutUI()
    }
}

private extension SettingVC {
    
    func configureView() {
        view.backgroundColor = Colors.backgroundSettingVC.uiColor
        view.addSubview(settingStack)
    }
    
    func configureNavBar() {
        title = LocalConstant.title
        navigationItem.setRightBarButton(UIBarButtonItem(title: LocalConstant.buttonTitle,
                                                         style: .done,
                                                         target: self,
                                                         action: #selector(close)), animated: true)
        let attributesButton = [
            NSAttributedString.Key.foregroundColor : Colors.closeButtonSettingVC.uiColor,
            NSAttributedString.Key.font : Fonts.closeButtonSettings.uiFont
        ]
        let attributesTitle = [
            NSAttributedString.Key.foregroundColor : Colors.titleSettingVC.uiColor,
            NSAttributedString.Key.font : Fonts.titleSettingVC.uiFont,
        ]
        navigationItem.rightBarButtonItem?.setTitleTextAttributes(attributesButton as [NSAttributedString.Key : Any],
                                                                  for: .normal)
        navigationController?.navigationBar.titleTextAttributes = attributesTitle
    }
    
    func layoutUI() {
        settingStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 56),
            settingStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            settingStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32)
        ])
    }
    
    @objc func close() { dismiss(animated: true) }
}

extension SettingVC: SettingVCProtocol {
    
    
}
