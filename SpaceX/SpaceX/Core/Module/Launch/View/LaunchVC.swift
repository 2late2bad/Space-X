//
//  LaunchVC.swift
//  SpaceX
//
//  Created by Alexander Vagin on 20.07.2023.
//

import UIKit

protocol LaunchVCProtocol: AnyObject {

}

final class LaunchVC: UIViewController {
    
    // MARK: - Properties
    var router: RocketRouterProtocol!
    var presenter: LaunchPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.backgroundLaunchVC.uiColor
        title = "Hello"
    }
    
}

// MARK: - Implementation LaunchVCProtocol
extension LaunchVC: LaunchVCProtocol {
    
}
