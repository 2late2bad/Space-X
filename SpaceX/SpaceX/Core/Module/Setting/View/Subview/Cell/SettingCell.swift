//
//  SettingCell.swift
//  SpaceX
//
//  Created by Alexander Vagin on 23.07.2023.
//

import UIKit

final class SettingCell: UICollectionViewCell {
    
    static let identifier = "SettingCell"
    
    // MARK: - Properties
    var segmentedValueChanged: ((Int) -> Void)?
    
    private let label = CVLabel(font: .labelRowSettingVC,
                                 color: .labelRowSettingVC,
                                 alignment: .left,
                                 lines: 1)
    
    private lazy var unitSegment: UISegmentedControl = {
        let segment = UISegmentedControl()
        segment.backgroundColor = Colors.backgroundSegmentControl.uiColor
        segment.selectedSegmentTintColor = Colors.selectedSegmentTintColor.uiColor
        segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colors.segmentedNormalText.uiColor],
                                       for: .normal)
        segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colors.segmentedSelectedText.uiColor],
                                       for: .selected)
        segment.addTarget(nil, action: #selector(segmentDidChange(_:)), for: .valueChanged)
        return segment
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [label, unitSegment])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configure(setting: Setting) {
        label.text = setting.type.name
        for (index, unit) in setting.type.units.enumerated() {
            unitSegment.insertSegment(withTitle: unit.name, at: index, animated: false)
        }
        unitSegment.selectedSegmentIndex = setting.selectedIndex
    }
}

// MARK: - Private ext
private extension SettingCell {
    
    func setup() {
        clipsToBounds = true
        contentView.addSubview(stackView)
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
    
    @objc func segmentDidChange(_ sender: UISegmentedControl) {
        segmentedValueChanged?(sender.selectedSegmentIndex)
    }
}
