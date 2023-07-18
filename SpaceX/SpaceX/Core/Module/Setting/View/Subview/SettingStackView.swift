//
//  SettingStackView.swift
//  SpaceX
//
//  Created by Alexander Vagin on 10.07.2023.
//

import UIKit

final class SettingStackView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SettingStackView {
    
    func configure() {
        axis = .vertical
        spacing = 24
        
        (0...3).forEach { _ in
            addArrangedSubview(SettingItemStackView())
        }
    }
}
