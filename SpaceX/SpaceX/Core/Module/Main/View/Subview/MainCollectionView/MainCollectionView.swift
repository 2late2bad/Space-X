//
//  MainCollectionView.swift
//  SpaceX
//
//  Created by Alexander Vagin on 08.07.2023.
//

import UIKit

final class MainCollectionView: UICollectionView {
    
    private var cells: [MainCollectionCell] = []
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let collecetionViewLayout = UICollectionViewFlowLayout()
        collecetionViewLayout.scrollDirection = .horizontal
        collecetionViewLayout.minimumInteritemSpacing = 12
        super.init(frame: .zero, collectionViewLayout: collecetionViewLayout)
        
        initialize()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MainCollectionView {
    
    func initialize() {
        register(MainCollectionCell.self, forCellWithReuseIdentifier: MainCollectionCell.identifier)
        dataSource = self
        delegate = self
        showsHorizontalScrollIndicator = false
        backgroundColor = Colors.backgroundContentView.uiColor
        
        // TODO: - Cells
        (1...4).forEach { _ in cells.append(MainCollectionCell()) }
    }
    
    func layoutUI() {
        contentInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
        pinToEdges(of: self)
    }
}

extension MainCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionCell.identifier,
                                                      for: indexPath) as! MainCollectionCell
        
        return cell
    }
}

extension MainCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 96, height: 96)
    }
}
