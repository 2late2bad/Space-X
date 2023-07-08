//
//  StageCell.swift
//  SpaceX
//
//  Created by Alexander Vagin on 08.07.2023.
//

import UIKit

final class StageCell: UITableViewCell {
    
    static let identifier = "StageCell"
    
    @IBOutlet private var mainLabel: UILabel!
    @IBOutlet private var valueLabel: UILabel!
    @IBOutlet private var unitLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    
    func configure(label: String, value: String, unit: String?) {
        mainLabel.text = label
        valueLabel.text = value
        unitLabel.text = unit
        checkUnit()
    }
}

private extension StageCell {
    
    func initialize() {
        isUserInteractionEnabled = false
        backgroundColor = Colors.backgroundContentView.uiColor
        
        mainLabel.font = Fonts.mainTextTableView.uiFont
        mainLabel.textColor = Colors.mainTextTableView.uiColor
        mainLabel.textAlignment = .left
        mainLabel.clipsToBounds = true
        mainLabel.adjustsFontSizeToFitWidth = true
        mainLabel.minimumScaleFactor = 0.8
        
        valueLabel.font = Fonts.valueStageTextTableView.uiFont
        valueLabel.textColor = Colors.valueTextTableView.uiColor
        valueLabel.textAlignment = .right
        valueLabel.clipsToBounds = true
        valueLabel.adjustsFontSizeToFitWidth = true
        valueLabel.minimumScaleFactor = 0.8
        
        unitLabel.font = Fonts.unitTextTableView.uiFont
        unitLabel.textColor = Colors.unitTextTableView.uiColor
        unitLabel.textAlignment = .right
    }
    
    func checkUnit() {
        // TODO: - Заменить stackView на label с фиксированной шириной, чтобы не костылить
        if let _ = unitLabel.text {
        
        } else {
            unitLabel.text = "zzz"
            unitLabel.layer.opacity = 0.5
        }
    }
}
