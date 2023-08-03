//
//  MainSectionHeader.swift
//  SpaceX
//
//  Created by Alexander Vagin on 08.07.2023.
//

import UIKit

final class MainSectionHeader: UITableViewHeaderFooterView {
    
    static let identifier = "SectionHeaderMainTable"
        
    // MARK: - Properties
    let titleLabel = CVLabel(font: .headerFooterTextView,
                                      color: .headerFooterTextTableView,
                                      alignment: .left,
                                      lines: 1)
    
    // MARK: - Init
    private override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configure()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private ext
private extension MainSectionHeader {
    
    func configure() {
        addSubview(titleLabel)
    }
    
    func layoutUI() {
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
