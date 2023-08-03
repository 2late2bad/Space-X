//
//  CVLabel.swift
//  SpaceX
//
//  Created by Alexander Vagin on 03.08.2023.
//

import UIKit

final class CVLabel: UILabel {
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(font: Fonts, color: Colors, alignment: NSTextAlignment, lines: Int) {
        self.init(frame: .zero)
        self.font = font.uiFont
        self.textColor = color.uiColor
        self.textAlignment = alignment
        self.numberOfLines = lines
    }
}

// MARK: - Private ext
private extension CVLabel {
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.8
        clipsToBounds = true
    }
}
