//
//  SettingCollectionView.swift
//  SpaceX
//
//  Created by Alexander Vagin on 23.07.2023.
//

import UIKit

final class SettingCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let collecetionViewLayout = UICollectionViewFlowLayout()
        collecetionViewLayout.scrollDirection = .vertical
        collecetionViewLayout.minimumLineSpacing = 24
        super.init(frame: .zero, collectionViewLayout: collecetionViewLayout)
        
        setup()
        style()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SettingCollectionView {
    
    func setup() {
        register(SettingCell.self, forCellWithReuseIdentifier: SettingCell.identifier)
    }
    
    func style() {
        backgroundColor = .clear
        showsVerticalScrollIndicator = false
    }
    
    func layoutUI() {
        contentInset = UIEdgeInsets(top: 56, left: 0, bottom: 56, right: 0)
    }
}
