//
//  MainVC.swift
//  SpaceX
//
//  Created by Alexander Vagin on 06.07.2023.
//

import UIKit

protocol MainVCProtocol: AnyObject {
    func configure(rocket: Rocket)
    func update(feature: [RocketFeature])
    func setImage(_ image: UIImage)
    func failureLoadSettings()
}

final class MainVC: UIViewController {
    
    // MARK: - Properties
    var router: RocketRouterProtocol!
    var presenter: MainPresenterProtocol!
    var rocketModel: RocketModel!
    
    // MARK: - Private properties
    private let contentView = MainContentView()
    private let rocketImage = RocketImageView(frame: .zero)
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    private var urlImage: String? {
        willSet {
            guard let newValue else { return }
            presenter.getImage(from: newValue)
        }
    }
    private var refreshStatus = false
    
    // Scroll limit (adapted for any device)
    private var minOffsetY: CGFloat { -rocketImage.frame.height * 0.05 }
    private var maxOffsetY: CGFloat { scrollView.contentSize.height - view.frame.height * 0.95 }
    
    // MARK: - Deinit
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
        addObservers()
        presenter.generateRocket(with: rocketModel)
        presenter.updateFeature()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        rollbackScrollPosition()
    }
}

// MARK: - MainVCProtocol Impl
extension MainVC: MainVCProtocol {
    
    func configure(rocket: Rocket) {
        contentView.configure(rocket: rocket)
        urlImage = rocket.images.randomElement()
    }
    
    func update(feature: [RocketFeature]) {
        contentView.configure(feature: feature)
    }
    
    func setImage(_ image: UIImage) {
        rocketImage.setImage(image)
    }
    
    func failureLoadSettings() {
        let alert = UIAlertController(title: "Ошибка данных",
                                      message: "Не получены настройки из хранилища",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .destructive)
        alert.addAction(action)
        present(alert, animated: true)
    }
}

// MARK: - Private ext
private extension MainVC {
    
    func setup() {
        view.addSubviews(rocketImage, scrollView)
        scrollView.delegate = self
        scrollView.addSubview(contentView)
        contentView.setup(delegate: self,
                          launchAction: openLaunchScreen,
                          presenter: presenter)
    }
    
    func openLaunchScreen() {
        router.routeLaunchModule(with: rocketModel.id, title: rocketModel.name)
    }
    
    func style() {
        view.backgroundColor = Colors.backgroundMainVC.uiColor
    }
    
    func layout() {
        scrollView.pinToEdges(of: view, safearea: false)
        
        rocketImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rocketImage.topAnchor.constraint(equalTo: view.topAnchor),
            rocketImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rocketImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rocketImage.heightAnchor.constraint(equalToConstant: view.frame.height * 0.57),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: view.frame.size.height / 2),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    func rollbackScrollPosition() {
        scrollView.scrollToTop(animated: true)
        contentView.collectionView.scrollToLeft(animated: true)
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateSettings),
                                               name: .updateSettings,
                                               object: nil)
    }
    
    @objc func updateSettings() {
        presenter.updateFeature()
    }
}

// MARK: - UIScrollViewDelegate
extension MainVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var offset = scrollView.contentOffset
        
        if offset.y < minOffsetY {
            refreshStatus = true
            rocketImage.startLoading()
            offset.y = minOffsetY
        }
        if offset.y > maxOffsetY { offset.y = maxOffsetY }
        
        scrollView.contentOffset = offset
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if refreshStatus {
            refreshStatus.toggle()
            urlImage = rocketModel.flickrImages.randomElement()
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if refreshStatus {
            refreshStatus.toggle()
            urlImage = rocketModel.flickrImages.randomElement()
        }
    }
}

// MARK: - MainHeaderViewDelegate
extension MainVC: MainHeaderViewDelegate {
    
    func didTapSettingButton() {
        router.routeSettingModule()
    }
}
