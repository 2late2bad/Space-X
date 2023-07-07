//
//  MainHeaderView.swift
//  SpaceX
//
//  Created by Alexander Vagin on 07.07.2023.
//

import UIKit

final class MainHeaderView: UIView {
    
    let label = UILabel()
    let settingButton = UIButton()
    let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        configure()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MainHeaderView {
    
    func setup() {
        addSubview(stackView)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(settingButton)
    }
    
    func configure() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        label.text = "Falcon X"
        label.textAlignment = .left
        label.textColor = Colors.titleRocket.uiColor
        label.font = Fonts.titleRocket.uiFont
        
        settingButton.setImage(UIImage(systemName: "gearshape"), for: .normal)
        settingButton.tintColor = Colors.settingsButton.uiColor
        
        settingButton.imageView?.contentMode = .scaleAspectFit
        settingButton.contentVerticalAlignment = .fill
        settingButton.contentHorizontalAlignment = .fill
    }
    
    func layout() {
        stackView.pinToEdges(of: self)
        
        settingButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingButton.heightAnchor.constraint(equalToConstant: 32),
            settingButton.widthAnchor.constraint(equalToConstant: 32)
        ])
    }
}
