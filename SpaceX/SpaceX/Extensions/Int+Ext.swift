//
//  Int+Ext.swift
//  SpaceX
//
//  Created by Alexander Vagin on 18.07.2023.
//

import Foundation

extension Int {
    var roundedDollars: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            if (number.truncatingRemainder(dividingBy: 1000000) == 0) {
                return "$\(Int(number) / 1000000) млн"
            } else {
                return "$\(round(million*10)/10) млн"
            }
        }
        else if thousand >= 1.0 {
            return "$\(round(thousand*10)/10)K"
        }
        else {
            return "\(self)"
        }
    }
}
