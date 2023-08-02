//
//  LaunchCell.swift
//  SpaceX
//
//  Created by Alexander Vagin on 22.07.2023.
//

import UIKit

final class LaunchCell: UITableViewCell {
    
    static let identifier = "LaunchCell"
    
    private let placeholderImage = UIImage(systemName: "questionmark.circle")?
        .withTintColor(Colors.tintStatusImageView.uiColor, renderingMode: .alwaysOriginal)
        
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.backgroundViewLaunchCell.uiColor
        view.layer.cornerRadius = 24
        return view
    }()
    
    private let nameLaunchLabel = CVLabel(font: .labelNameLaunchCell,
                                          color: .nameLaunchLabel,
                                          alignment: .left,
                                          lines: 1)
    
    private let dateLaunchLabel = CVLabel(font: .labelDateLaunchCell,
                                          color: .dateLaunchLabel,
                                          alignment: .left,
                                          lines: 1)
    
    private let launchStatusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = Colors.tintStatusImageView.uiColor
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLaunchLabel, dateLaunchLabel])
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        styleCell()
        layoutCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(name: String, date: String, result: Bool?) {
        nameLaunchLabel.text = name
        dateLaunchLabel.text = date.convertToDisplayFormat(from: .server)
        
        guard let result = result else {
            launchStatusImageView.image = placeholderImage
            return
        }
        
        if result {
            launchStatusImageView.image = UIImage(named: "rocketSuccess")
        } else {
            launchStatusImageView.image = UIImage(named: "rocketUnsuccess")
        }
    }
}

private extension LaunchCell {
    
    func setupCell() {
        isUserInteractionEnabled = false
        contentView.addSubview(backView)
        contentView.addSubview(launchStatusImageView)
        contentView.addSubview(labelsStackView)
    }
    
    func styleCell() {
        backgroundColor = .clear
    }
    
    func layoutCell() {
        backView.translatesAutoresizingMaskIntoConstraints = false
        launchStatusImageView.translatesAutoresizingMaskIntoConstraints = false
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            launchStatusImageView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -32),
            launchStatusImageView.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            launchStatusImageView.heightAnchor.constraint(equalToConstant: 32),
            launchStatusImageView.widthAnchor.constraint(equalToConstant: 32),
            
            labelsStackView.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            labelsStackView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 24),
            labelsStackView.trailingAnchor.constraint(equalTo: launchStatusImageView.leadingAnchor, constant: -8)
        ])
    }
}
