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
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        //scrollView.contentSize = contentSize
        scrollView.frame = view.bounds
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
//    private lazy var contentView: UIView = {
//        let contentView = MainContentVC()
//        contentView.backgroundColor = .black
//        contentView.layer.cornerRadius = 40
//        return contentView
//    }()
    
    private let contentView = MainContentView()
    
    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    lazy var testImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.image = UIImage(named: "testRocket")!
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(testImage)
        view.addSubview(scrollView)

        scrollView.delegate = self
        scrollView.addSubview(contentView)
        
        //scrollView.isHidden = true
        
        layout()
        presenter.getDataRockets(numbRocket: pageNumb)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentOffset.y), animated: true)
    }
    
}

private extension MainVC {
    
    func layout() {
        testImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            testImage.topAnchor.constraint(equalTo: view.topAnchor),
            testImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            testImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            testImage.heightAnchor.constraint(equalToConstant: view.frame.height * 0.60)
        ])
        
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 300),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: view.frame.height)
        ])
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
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView.contentOffset.y < -200 {
//            scrollView.contentOffset.y = -200
//        }
//
//        if scrollView.contentOffset.y > view.frame.height {
//            scrollView.contentOffset.y = view.frame.height
//        }
//    }
}
