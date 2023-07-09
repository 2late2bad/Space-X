//
//  MainTableModel.swift
//  SpaceX
//
//  Created by Alexander Vagin on 08.07.2023.
//

import Foundation

enum UnitMainTable: String {
    case fuel = "ton"
    case time = "sec"
}

enum SectionMainType: String {
    case info
    case firstStage = "Первая ступень"
    case secondStage = "Вторая ступень"
    case launchButton
}

enum CellMainType {
    case info
    case stage(unit: UnitMainTable?)
    case button
}

struct SectionMainTable {
    let type: SectionMainType
    var cells: [CellMainTable]
}

struct CellMainTable {
    let type: CellMainType
    let label: String
    var value: String?
    
    var unit: String? {
        switch type {
        case .stage(let unit):
            return unit?.rawValue
        default:
            return nil
        }
    }
}
