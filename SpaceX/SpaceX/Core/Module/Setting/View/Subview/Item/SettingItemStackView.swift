//
//  SettingItemStackView.swift
//  SpaceX
//
//  Created by Alexander Vagin on 10.07.2023.
//

import UIKit

final class SettingItemStackView: UIStackView {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = Fonts.labelRowSettingVC.uiFont
        label.textColor = Colors.labelRowSettingVC.uiColor
        label.textAlignment = .left
        label.clipsToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        return label
    }()
    
    private lazy var unitSegment: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["kg", "ft"])
        segment.selectedSegmentIndex = 0
        segment.backgroundColor = Colors.backgroundSegmentControl.uiColor
        segment.selectedSegmentTintColor = Colors.selectedSegmentTintColor.uiColor
        segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colors.segmentedNormalText.uiColor],
                                       for: .normal)
        segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colors.segmentedSelectedText.uiColor],
                                       for: .selected)
        return segment
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layoutUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SettingItemStackView {
    
    func configure() {
        addArrangedSubview(label)
        addArrangedSubview(unitSegment)
        axis = .horizontal
        distribution = .equalSpacing
    }
    
    func layoutUI() {
        unitSegment.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            unitSegment.widthAnchor.constraint(greaterThanOrEqualToConstant: 115),
            unitSegment.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
