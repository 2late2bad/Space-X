//
//  String+Ext.swift
//  SpaceX
//
//  Created by Alexander Vagin on 18.07.2023.
//

import Foundation

extension String {
    
    func convertToDate() -> Date? {
        let dateFormatter        = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale     = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone   = .current
        
        return dateFormatter.date(from: self)
    }
    
    func convertToDisplayFormat() -> String {
        guard let date = self.convertToDate() else { return "N/A" }
        return date.convertToLaunchFormat()
    }
    
    func convertCountryToRus() -> String {
        switch self {
        case "United States":
            return "США"
        case "Republic of the Marshall Islands":
            return "Маршалловы Острова"
        default:
            return self
        }
    }
}
