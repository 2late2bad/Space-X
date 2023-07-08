//
//  MainContentView.swift
//  SpaceX
//
//  Created by Alexander Vagin on 07.07.2023.
//

import UIKit

final class MainContentView: UIView {
    
    private let header = MainHeaderView()
    private let collectionView = MainCollectionView()
    private let tableView = MainTableView()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MainContentView {
    
    func initialize() {
    }
    
    func style() {
        backgroundColor = Colors.backgroundContentView.uiColor
        layer.cornerRadius = 40
        
        // delete
//        header.layer.borderWidth = 1
//        header.layer.borderColor = .init(red: 100, green: 100, blue: 100, alpha: 0.3)
//        collectionView.layer.borderWidth = 1
//        collectionView.layer.borderColor = .init(red: 100, green: 100, blue: 100, alpha: 0.3)
//        tableView.layer.borderWidth = 1
//        tableView.layer.borderColor = .init(red: 100, green: 100, blue: 100, alpha: 0.3)
    }
    
    func layout() {
        header.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: topAnchor, constant: 48),
            header.leftAnchor.constraint(equalTo: leftAnchor, constant: 32),
            header.rightAnchor.constraint(equalTo: rightAnchor, constant: -32),
            header.heightAnchor.constraint(equalToConstant: 32),
            
            collectionView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 32),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 96),
            
            tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 40),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: footerButton.topAnchor),
            
        ])
    }
}
