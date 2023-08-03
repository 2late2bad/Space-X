//
//  MainCollectionCell.swift
//  SpaceX
//
//  Created by Alexander Vagin on 08.07.2023.
//

import UIKit

final class MainCollectionCell: UICollectionViewCell {
    
    static let identifier = "MainCollectionCell"
    
    // MARK: - Private properties
    private let areaView = UIView()
    private let mainLabel = CVLabel(font: .mainCollectionCellTitle,
                                     color: .titleCollectionCell,
                                     alignment: .center,
                                     lines: 1)
    private let detailsLabel = CVLabel(font: .mainCollectionCellSubtitle,
                                     color: .subtitleCollectionCell,
                                     alignment: .center,
                                     lines: 1)
    
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
    
    // MARK: - Methods
    func configure(feature: RocketFeature) {
        switch feature.type {
        case .height, .diameter:
            mainLabel.text = String(feature.value)
        case .weight, .payload:
            let intValue = Int(feature.value)
            mainLabel.text = intValue.stringDecimal
        }
        detailsLabel.text = "\(feature.type.name), \(feature.type.units[feature.selectedIndex].name)"
    }
}

// MARK: - Private ext
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
