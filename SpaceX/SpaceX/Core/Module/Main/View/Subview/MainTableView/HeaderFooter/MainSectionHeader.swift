//
//  MainSectionHeader.swift
//  SpaceX
//
//  Created by Alexander Vagin on 08.07.2023.
//

import UIKit

final class MainSectionHeader: UITableViewHeaderFooterView {
    
    static let identifier = "SectionHeaderMainTable"
    
    let titleLabel: UILabel = {
        $0.font = Fonts.headerFooterTextView.uiFont
        $0.textColor = Colors.headerFooterTextTableView.uiColor
        $0.textAlignment = .left
        $0.clipsToBounds = true
        return $0
    }(UILabel())

    private override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configure()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MainSectionHeader {
    
    func configure() {
        addSubview(titleLabel)
    }
    
    func layoutUI() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                             constant: 32),
            titleLabel.rightAnchor.constraint(greaterThanOrEqualTo: contentView.rightAnchor,
                                              constant: -32)
        ])
    }
}
