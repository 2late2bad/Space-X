//
//  String+Ext.swift
//  SpaceX
//
//  Created by Alexander Vagin on 18.07.2023.
//

import Foundation

extension String {
    
    var localized: String {
        NSLocalizedString(self, comment: "\(self) could not be found in Localizable.strings")
    }
    
    private func convertToDate(format: C.DateFormat) -> Date? {
        let dateFormatter        = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.locale     = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone   = .current
        
        return dateFormatter.date(from: self)
    }
    
    func convertToDisplayFormat(from: C.DateFormat) -> String {
        guard let date = self.convertToDate(format: from) else { return "N/A" }
        return date.convertToLaunchFormat()
    }    
}
