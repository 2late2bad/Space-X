//
//  MainContentView.swift
//  SpaceX
//
//  Created by Alexander Vagin on 07.07.2023.
//

import UIKit

final class MainContentView: UIView {
    
    let header = MainHeaderView()
    
    // MARK: - Init
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

private extension MainContentView {
    
    func setup() {
        addSubview(header)
    }
    
    func configure() {
        backgroundColor = .black
        layer.cornerRadius = 40
        
        // delete
        header.layer.borderWidth = 1
        header.layer.borderColor = .init(red: 100, green: 100, blue: 100, alpha: 0.3)
    }
    
    func layout() {
        header.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: self.topAnchor, constant: 48),
            header.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 32),
            header.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -32),
            header.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
}
