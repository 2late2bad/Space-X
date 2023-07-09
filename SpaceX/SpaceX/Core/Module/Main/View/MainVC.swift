//
//  MainVC.swift
//  SpaceX
//
//  Created by Alexander Vagin on 06.07.2023.
//

import UIKit

protocol MainVCProtocol: AnyObject {
    //func success(rockets: [RocketData])
}

final class MainVC: UIViewController {
    
    // MARK: - Properties
    var router: RocketRouterProtocol!
    var presenter: MainPresenterProtocol!
    var pageNumb: Int!
    
    // MARK: - Private properties
    private let contentView = MainContentView()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    private lazy var rocketImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.image = UIImage(named: "testRocket")!
        return view
    }()
    
    // Scroll limit (adapted for any device)
    private var minOffsetY: CGFloat { -rocketImage.frame.height * 0.1 }
    private var maxOffsetY: CGFloat { scrollView.contentSize.height - view.frame.height * 0.95 }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
        presenter.getDataRockets(numbRocket: pageNumb)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        rollbackScrollPosition()
    }
}

private extension MainVC {
    
    func setup() {
        view.addSubviews(rocketImage, scrollView)
        scrollView.delegate = self
        scrollView.addSubview(contentView)
    }
    
    func style() {
        view.backgroundColor = Colors.backgroundMainVC.uiColor
    }
    
    func layout() {
        scrollView.pinToEdges(of: view)
        
        rocketImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            rocketImage.topAnchor.constraint(equalTo: view.topAnchor),
            rocketImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rocketImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rocketImage.heightAnchor.constraint(equalToConstant: view.frame.height * 0.60),
            
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
}



extension MainVC: MainVCProtocol {
    
    func success(rockets: [RocketData]) {
        //rockets[pageNumb].flickrImages
//        if let firstImage = rockets[pageNumb].flickrImages.first {
//            
//            DispatchQueue.main.async {
//                guard let url = URL(string: firstImage),
//                      let data = try? Data(contentsOf: url) else { return }
//                self.testImage.image = UIImage(data: data)
//
//            }
//
//
//
//
//        }
        
//        guard let url = URL(string: stringURL),
//              let data = try? Data(contentsOf: url) else { return Data() }
//
//        return data
    }
}

extension MainVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var offset = scrollView.contentOffset
        
        if offset.y < minOffsetY { offset.y = minOffsetY }
        if offset.y > maxOffsetY { offset.y = maxOffsetY }
        
        scrollView.contentOffset = offset
    }
}
