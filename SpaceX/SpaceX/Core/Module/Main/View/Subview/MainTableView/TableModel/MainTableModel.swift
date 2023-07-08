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
}

enum CellMainType {
    case info
    case stage(unit: UnitMainTable?)
}

struct SectionMainTable {
    let type: SectionMainType
    var cells: [CellMainTable]
}

struct CellMainTable {
    let type: CellMainType
    
    let label: String
    let value: String
    
    var unit: String? {
        switch type {
        case .info:
            return nil
        case .stage(let unit):
            return unit?.rawValue
        }
    }
}
