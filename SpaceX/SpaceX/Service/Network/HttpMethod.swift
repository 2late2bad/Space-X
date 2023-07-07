//
//  HttpMethod.swift
//  SpaceX
//
//  Created by Alexander Vagin on 07.07.2023.
//

import Foundation

enum HttpMethod: String {
    case get
    case post
    
    var method: String { rawValue.uppercased() }
}
