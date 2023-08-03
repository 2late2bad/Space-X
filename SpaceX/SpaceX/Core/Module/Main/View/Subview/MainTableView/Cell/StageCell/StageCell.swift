//
//  StageCell.swift
//  SpaceX
//
//  Created by Alexander Vagin on 08.07.2023.
//

import UIKit

final class StageCell: UITableViewCell {
    
    static let identifier = "StageCell"
    
    // MARK: - Properties
    @IBOutlet private var mainLabel: UILabel!
    @IBOutlet private var valueLabel: UILabel!
    @IBOutlet private var unitLabel: UILabel!

    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    
    // MARK: - Methods
    func configure(label: String?, value: String?, unit: String?) {
        mainLabel.text = label
        valueLabel.text = value
        unitLabel.text = unit
    }
}

// MARK: - Private ext
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
    }
}
