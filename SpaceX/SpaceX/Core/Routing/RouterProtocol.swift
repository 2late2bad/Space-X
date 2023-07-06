//
//  Router.swift
//  SpaceX
//
//  Created by Alexander Vagin on 06.07.2023.
//

import UIKit

protocol RouterProtocol {
    init(navigationController: UINavigationController,
         moduleBuilder: ModuleBuilderProtocol)
}
