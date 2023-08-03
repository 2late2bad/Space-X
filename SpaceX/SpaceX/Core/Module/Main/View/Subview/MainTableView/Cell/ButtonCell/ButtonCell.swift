//
//  ButtonCell.swift
//  SpaceX
//
//  Created by Alexander Vagin on 09.07.2023.
//

import UIKit

final class ButtonCell: UITableViewCell {
    
    static let identifier = "ButtonCell"
    
    // MARK: - Properties
    @IBOutlet weak var launchButton: UIButton!
    var buttonAction: C.Callback?
    
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    
    // MARK: - Methods
    func configure(label: String?) {
        launchButton.setTitle(label, for: .normal)
    }
    
    @IBAction func launchButtonPressed(_ sender: UIButton) {
        buttonAction?()
    }
}

// MARK: - Private ext
private extension ButtonCell {
    
    func initialize() {
        backgroundColor = .black
        launchButton.backgroundColor = Colors.backgroundFooterButton.uiColor
        launchButton.layer.cornerRadius = 12
        launchButton.setTitleColor(Colors.titleFooterButton.uiColor, for: .normal)
        launchButton.titleLabel?.font = Fonts.launchesButton.uiFont
        launchButton.startAnimatingPressActions()
    }
}
