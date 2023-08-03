//
//  SettingVC.swift
//  SpaceX
//
//  Created by Alexander Vagin on 10.07.2023.
//

import UIKit

protocol SettingVCProtocol: AnyObject {
    func postNotification(name: NSNotification.Name, object: Any?)
    func failureLoadSettings()
}

final class SettingVC: UIViewController {
    
    // MARK: - Local constants
    private enum LocalConstant {
        static let title: String = "settings_title".localized
        static let buttonTitle: String = "close_button".localized
    }
    
    // MARK: - Properties
    var router: RocketRouterProtocol!
    var presenter: SettingPresenterProtocol!
    private let collectionView = SettingCollectionView()
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        presenter.loadSettins()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureNavBar()
        layoutUI()
    }
}

// MARK: - SettingVCProtocol Impl
extension SettingVC: SettingVCProtocol {
    
    func postNotification(name: NSNotification.Name, object: Any?) {
        NotificationCenter.default.post(name: name, object: object)
    }
    
    func failureLoadSettings() {
        let alert = UIAlertController(title: "Ошибка данных",
                                      message: "Не получены настройки из хранилища",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .destructive) { [weak self] action in
            self?.dismiss(animated: true)
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
}

// MARK: - Private ext
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

// MARK: - UICollectionViewDataSource
extension SettingVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingCell.identifier, for: indexPath) as? SettingCell else { return UICollectionViewCell() }
        let indexItem = indexPath.item
        cell.configure(setting: presenter.settings[indexItem])
        cell.segmentedValueChanged = { [weak self] selectedIndex in
            guard let self else { return }
            self.presenter.updateSegment(selected: selectedIndex, indexItem: indexItem)
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SettingVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 56, left: 0, bottom: 56, right: 0)
    }
}
