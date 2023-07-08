//
//  InfoCell.swift
//  SpaceX
//
//  Created by Alexander Vagin on 08.07.2023.
//

import UIKit

final class InfoCell: UITableViewCell {
    
    static let identifier = "InfoCell"
    
    @IBOutlet private var mainLabel: UILabel!
    @IBOutlet private var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
        
    func configure(label: String, value: String) {
        mainLabel.text = label
        valueLabel.text = value
    }
}

private extension InfoCell {
    
    func initialize() {
        isUserInteractionEnabled = false
        backgroundColor = Colors.backgroundContentView.uiColor
        
        mainLabel.font = Fonts.mainTextTableView.uiFont
        mainLabel.textColor = Colors.mainTextTableView.uiColor
        mainLabel.textAlignment = .left
        mainLabel.clipsToBounds = true
        mainLabel.adjustsFontSizeToFitWidth = true
        mainLabel.minimumScaleFactor = 0.8
        
        valueLabel.font = Fonts.mainTextTableView.uiFont
        valueLabel.textColor = Colors.valueTextTableView.uiColor
        valueLabel.textAlignment = .right
        valueLabel.clipsToBounds = true
        valueLabel.adjustsFontSizeToFitWidth = true
        valueLabel.minimumScaleFactor = 0.8
    }
}
