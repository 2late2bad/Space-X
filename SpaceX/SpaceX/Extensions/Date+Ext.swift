//
//  Date+Ext.swift
//  SpaceX
//
//  Created by Alexander Vagin on 18.07.2023.
//

import Foundation

extension Date {
    
    func convertToLaunchFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM, yyyy"
        dateFormatter.locale     = Locale(identifier: "id_locale".localized)
        return dateFormatter.string(from: self)
    }
}
