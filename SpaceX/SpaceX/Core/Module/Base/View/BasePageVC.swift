//
//  BasePageVC.swift
//  SpaceX
//
//  Created by Alexander Vagin on 06.07.2023.
//

import UIKit

protocol BasePageProtocol: AnyObject {
    
}

final class BasePageVC: UIPageViewController {
    
    // MARK: - Properties
    var router: RocketRouterProtocol!
    var presenter: BasePresenterProtocol!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
    }
}

// MARK: - Implementation BasePageProtocol

extension BasePageVC: BasePageProtocol {
    
}
