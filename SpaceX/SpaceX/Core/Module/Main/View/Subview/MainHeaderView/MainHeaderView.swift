//
//  MainHeaderView.swift
//  SpaceX
//
//  Created by Alexander Vagin on 07.07.2023.
//

import UIKit

protocol MainHeaderViewDelegate: AnyObject {
    func didTapSettingButton()
}

final class MainHeaderView: UIView {
    
    let label = UILabel()
    let settingButton = UIButton()
    let stackView = UIStackView()
    
    weak var delegate: MainHeaderViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        style()
        configureButton()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func settingsButtonTapped() {
        delegate.didTapSettingButton()
    }
}

private extension MainHeaderView {
    
    func setup() {
        addSubview(stackView)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(settingButton)
    }
    
    func style() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        label.textAlignment = .left
        label.textColor = Colors.titleRocket.uiColor
        label.font = Fonts.titleRocket.uiFont
        
        settingButton.setImage(UIImage(systemName: "gearshape"), for: .normal)
        settingButton.tintColor = Colors.settingsButton.uiColor
        settingButton.imageView?.contentMode = .scaleAspectFit
        settingButton.contentVerticalAlignment = .fill
        settingButton.contentHorizontalAlignment = .fill
    }
    
    func configureButton() {
        settingButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        settingButton.startAnimatingPressActions()
    }
    
    func layout() {
        stackView.pinToEdges(of: self, safearea: false)
        
        settingButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingButton.heightAnchor.constraint(equalToConstant: 32),
            settingButton.widthAnchor.constraint(equalToConstant: 32)
        ])
    }
}
