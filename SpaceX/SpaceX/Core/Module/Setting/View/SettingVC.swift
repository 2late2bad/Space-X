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
    
    var settings: [Setting]! {
        willSet {
            StorageManager.shared.set(object: newValue, forKey: .settings)
        }
    }
    
    private enum LocalConstant {
        static let title: String = "Настройки"
        static let buttonTitle: String = "Закрыть"
    }
    
    var router: RocketRouterProtocol!
    var presenter: SettingPresenterProtocol!
        
    private let collectionView = SettingCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureNavBar()
        layoutUI()
    }
}

extension SettingVC: SettingVCProtocol {
    
    
}

private extension SettingVC {
    
    func setup() {
        view.backgroundColor = Colors.backgroundSettingVC.uiColor
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
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
        navigationController?.navigationBar.barTintColor = Colors.backgroundSettingVC.uiColor
    }
    
    func layoutUI() {
        collectionView.pinToEdges(of: view, safearea: true)
    }
    
    @objc func close() { dismiss(animated: true) }
}

extension SettingVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingCell.identifier, for: indexPath) as? SettingCell else { return UICollectionViewCell() }
        let indexItem = indexPath.item
        cell.configure(setting: settings[indexItem])
        cell.segmentedValueChanged = { [weak self] selectedIndex in
            guard let self else { return }
            self.settings[indexItem].selectedIndex = selectedIndex
            NotificationCenter.default.post(name: .updateSettings, object: nil)
        }
        return cell
    }
}

extension SettingVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 56, left: 0, bottom: 56, right: 0)
    }
}
