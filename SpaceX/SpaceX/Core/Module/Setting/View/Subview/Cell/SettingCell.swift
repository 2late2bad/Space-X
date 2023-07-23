//
//  SettingCell.swift
//  SpaceX
//
//  Created by Alexander Vagin on 23.07.2023.
//

import UIKit

final class SettingCell: UICollectionViewCell {
    
    static let identifier = "SettingCell"
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = Fonts.labelRowSettingVC.uiFont
        label.textColor = Colors.labelRowSettingVC.uiColor
        label.textAlignment = .left
        label.clipsToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        return label
    }()
    
    private lazy var unitSegment: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["m", "ft"])
        segment.selectedSegmentIndex = 0
        segment.backgroundColor = Colors.backgroundSegmentControl.uiColor
        segment.selectedSegmentTintColor = Colors.selectedSegmentTintColor.uiColor
        segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colors.segmentedNormalText.uiColor],
                                       for: .normal)
        segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colors.segmentedSelectedText.uiColor],
                                       for: .selected)
        return segment
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [label, unitSegment])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        style()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(test: String) {
        label.text = test
    }
}

private extension SettingCell {
    
    func setup() {
        clipsToBounds = true
        contentView.addSubview(stackView)
    }
    
    func style() {
//        unitSegment.removeAllSegments()
//        unitSegment.insertSegment(withTitle: "lohasdd", at: 0, animated: true)
//        unitSegment.insertSegment(withTitle: "nasdasdasde", at: 1, animated: true)
//        unitSegment.selectedSegmentIndex = 0
    }
    
    func layoutUI() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        unitSegment.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 28),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -28),

            unitSegment.widthAnchor.constraint(greaterThanOrEqualToConstant: 115)
        ])
    }
}
