//
//  MainVC.swift
//  SpaceX
//
//  Created by Alexander Vagin on 06.07.2023.
//

import UIKit

protocol MainVCProtocol: AnyObject {
    func success(rocket: Rocket)
    func success(feature: [Feature])
    func failure()
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
    
    // Scroll limit (adapted for any device)
    private var minOffsetY: CGFloat { -rocketImage.frame.height * 0.05 }
    private var maxOffsetY: CGFloat { scrollView.contentSize.height - view.frame.height * 0.95 }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
        addObservers()
        presenter.getRocket(with: rocketModel)
        presenter.updateFeature()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        rollbackScrollPosition()
    }
}

// MARK: - Implementation MainVCProtocol
extension MainVC: MainVCProtocol {
    
    func success(rocket: Rocket) {
        contentView.configure(rocket: rocket)
        rocketImage.downloadImage(fromURL: rocket.images.randomElement()!)
    }
    
    func success(feature: [Feature]) {
        contentView.collectionView.configure(features: feature)
    }
    
    func failure() {
        //
    }
}

// MARK: - Private methods
private extension MainVC {
    
    func setup() {
        view.addSubviews(rocketImage, scrollView)
        scrollView.delegate = self
        scrollView.addSubview(contentView)
        contentView.header.delegate = self
        contentView.tableView.buttonAction = openLaunchScreen
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
        
        if offset.y < minOffsetY { offset.y = minOffsetY }
        if offset.y > maxOffsetY { offset.y = maxOffsetY }
        
        scrollView.contentOffset = offset
    }
}

// MARK: - MainHeaderViewDelegate
extension MainVC: MainHeaderViewDelegate {
    
    func didTapSettingButton() {
        router.routeSettingModule()
    }
}
