//
//  MainCollectionCell.swift
//  SpaceX
//
//  Created by Alexander Vagin on 08.07.2023.
//

import UIKit

final class MainCollectionCell: UICollectionViewCell {
    
    static let identifier = "MainCollectionCell"
    
    private let areaView = UIView()
    
    private lazy var mainLabel: UILabel = {
        $0.font = Fonts.mainCollectionCellTitle.uiFont
        $0.textColor = Colors.titleCollectionCell.uiColor
        $0.textAlignment = .center
        $0.numberOfLines = 1
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.8
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private lazy var detailsLabel: UILabel = {
        $0.font = Fonts.mainCollectionCellSubtitle.uiFont
        $0.textColor = Colors.subtitleCollectionCell.uiColor
        $0.textAlignment = .center
        $0.numberOfLines = 1
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.7
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(feature: Feature) {
        mainLabel.text = feature.value
        detailsLabel.text = "\(feature.name), \(feature.type.description.us)"
    }
}

private extension MainCollectionCell {
    
    func initialize() {
        contentView.addSubview(areaView)
        areaView.addSubviews(mainLabel, detailsLabel)
    }
    
    func style() {
        areaView.backgroundColor = Colors.backgroundCollectionCell.uiColor
        areaView.layer.cornerRadius = 32
    }
    
    func layout() {
        areaView.pinToEdges(of: contentView, safearea: false)
        
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: areaView.topAnchor, constant: 28),
            mainLabel.leftAnchor.constraint(equalTo: areaView.leftAnchor, constant: 8),
            mainLabel.rightAnchor.constraint(equalTo: areaView.rightAnchor, constant: -8),
            
            detailsLabel.bottomAnchor.constraint(equalTo: areaView.bottomAnchor, constant: -24),
            detailsLabel.leftAnchor.constraint(equalTo: areaView.leftAnchor, constant: 8),
            detailsLabel.rightAnchor.constraint(equalTo: areaView.rightAnchor, constant: -8)
        ])
    }
}
