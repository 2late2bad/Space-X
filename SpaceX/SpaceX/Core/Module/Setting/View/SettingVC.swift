//
//  SettingVC.swift
//  SpaceX
//
//  Created by Alexander Vagin on 10.07.2023.
//

import UIKit

protocol SettingVCProtocol: AnyObject {
    
}

protocol SettingVCDelegate: AnyObject {
    func saveSettings()
}

final class SettingVC: UIViewController {
    
    //
    private var settings: [Setting] = [] {
        willSet {
            StorageManager.shared.set(object: newValue, forKey: .settings)
        }
    }
    //
    
    private enum LocalConstant {
        static let title: String = "Настройки"
        static let buttonTitle: String = "Закрыть"
    }
    
    var router: RocketRouterProtocol!
    var presenter: SettingPresenterProtocol!
    weak var delegate: SettingVCDelegate!
        
    private let collectionView = SettingCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureNavBar()
        layoutUI()
        testLoad()
    }
}

private extension SettingVC {
    
    func setup() {
        view.backgroundColor = Colors.backgroundSettingVC.uiColor
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        navigationController?.presentationController?.delegate = self
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
    
    @objc func close() {
        delegate.saveSettings()
        dismiss(animated: true)
    }
    
    //
    func testLoad() {
        if let settings: [Setting] = StorageManager.shared.decodableData(forKey: .settings) {
            self.settings = settings
        } else {
            self.settings = [Setting(type: .height, selectedIndex: 0),
                        Setting(type: .diameter, selectedIndex: 0),
                        Setting(type: .weight, selectedIndex: 0),
                          Setting(type: .payload, selectedIndex: 0)]
        }
    }
}

extension SettingVC: SettingVCProtocol {
    
    
}

extension SettingVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingCell.identifier, for: indexPath) as? SettingCell else { return UICollectionViewCell() }
        let indexItem = indexPath.item
        cell.configure(setting: settings[indexItem], index: indexItem)
        cell.segmentedValueChanged = { [weak self] item in
            self?.settings[item.item].selectedIndex = item.segment
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

extension SettingVC: UIAdaptivePresentationControllerDelegate {
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        delegate.saveSettings()
    }
}
