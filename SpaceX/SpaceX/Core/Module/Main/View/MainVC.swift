//
//  MainVC.swift
//  SpaceX
//
//  Created by Alexander Vagin on 06.07.2023.
//

import UIKit

protocol MainVCProtocol: AnyObject {
    
}

final class MainVC: UIViewController {
    
    // MARK: - Properties
    var router: RocketRouterProtocol!
    var presenter: MainPresenterProtocol!
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        //scrollView.backgroundColor = .brown
        scrollView.contentSize = contentSize
        scrollView.frame = view.bounds
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = MainContentVC()
        contentView.backgroundColor = .black
        contentView.layer.cornerRadius = 40
        return contentView
    }()
    
    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + 300)
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
            
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: view.frame.height)
        ])
    }
}

extension MainVC: MainVCProtocol {
    
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
