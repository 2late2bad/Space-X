//
//  FooterButton.swift
//  SpaceX
//
//  Created by Alexander Vagin on 08.07.2023.
//

import UIKit

final class LaunchButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension LaunchButton {
    
    func configure() {
        backgroundColor = Colors.backgroundFooterButton.uiColor
        layer.cornerRadius = 12
        setTitle("Посмотреть запуски", for: .normal)
        setTitleColor(Colors.titleFooterButton.uiColor, for: .normal)
        titleLabel?.font = Fonts.launchesButton.uiFont
    }
}
