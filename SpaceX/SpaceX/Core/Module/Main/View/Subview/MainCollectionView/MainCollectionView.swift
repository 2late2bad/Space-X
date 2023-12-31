//
//  MainCollectionView.swift
//  SpaceX
//
//  Created by Alexander Vagin on 08.07.2023.
//

import UIKit

final class MainCollectionView: UICollectionView {
    
    // MARK: - Private properties
    private var features: [RocketFeature] = []
    
    // MARK: - Init
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
    
    // MARK: - Methods
    func configure(features: [RocketFeature]) {
        self.features = features
        DispatchQueue.main.async { [weak self] in
            self?.reloadData()
        }
    }
}

// MARK: - Private ext
private extension MainCollectionView {
    
    func initialize() {
        register(MainCollectionCell.self, forCellWithReuseIdentifier: MainCollectionCell.identifier)
        dataSource = self
        delegate = self
        showsHorizontalScrollIndicator = false
        backgroundColor = Colors.backgroundContentView.uiColor
        
        contentInsetAdjustmentBehavior = .never
    }
    
    func layoutUI() {
        contentInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
        pinToEdges(of: self, safearea: false)
    }
}

// MARK: - UICollectionViewDataSource
extension MainCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        features.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionCell.identifier,
                                                      for: indexPath) as! MainCollectionCell
        cell.configure(feature: features[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 96, height: 96)
    }
}
