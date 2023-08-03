//
//  MainTableModel.swift
//  SpaceX
//
//  Created by Alexander Vagin on 08.07.2023.
//

import Foundation

// MARK: - MainTable constants
enum MainTableConstants {
    static let cellHeight: CGFloat = 40
    static let cellButtonHeight: CGFloat = 56
    static let sectionHeaderStageHeight: CGFloat = 32
    static let sectionHeaderDefaultHeight: CGFloat = 0
    static let sectionFooterBeginnersStageHeight: CGFloat = 32
    static let sectionFooterFinalsStageHeight: CGFloat = 24
}

// MARK: - Section type
enum SectionMainType: String {
    case info
    case firstStage = "first_stage_rocket"
    case secondStage = "second_stage_rocket"
    case launchButton
}

// MARK: - Cell type
enum CellMainType {
    case info
    case stage(unit: UnitMainTable?)
    case button
}

// MARK: - Unit model for Cell
enum UnitMainTable: String {
    case fuel = "ton"
    case time = "sec"
}

// MARK: - Section Model
struct SectionMainTable {
    let type: SectionMainType
    var cells: [CellMainTable]
}

// MARK: - Cell Model
struct CellMainTable {
    let type: CellMainType
    let label: String?
    var value: String?
    
    var unit: String? {
        switch type {
        case .stage(let unit):
            return unit?.rawValue
        default: return nil
        }
    }
}
