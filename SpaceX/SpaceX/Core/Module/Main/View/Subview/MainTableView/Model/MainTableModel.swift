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

struct MainTableModel {
        
    func generateData(with rocket: Rocket) -> [SectionMainTable] {
        var dataTable: [SectionMainTable] = []
        
        let infoSectionCells = [CellMainTable(type: .info,
                                              label: "first_launch_rocket".localized,
                                              value: rocket.firstFlight.convertToDisplayFormat(from: .fullYearMonthDay)),
                                CellMainTable(type: .info,
                                              label: "country_rocket".localized,
                                              value: rocket.country.localized),
                                CellMainTable(type: .info,
                                              label: "launch_cost_rocket".localized,
                                              value: rocket.costPerLaunch.roundedDollars)]
        
        let firstStageSectionCells = [CellMainTable(type: .stage(unit: nil),
                                                    label: "number_engines_rocket".localized,
                                                    value: String(rocket.firstStage.engines)),
                                      CellMainTable(type: .stage(unit: .fuel),
                                                    label: "amount_fuel_rocket".localized,
                                                    value: String(rocket.firstStage.fuelAmountTons))]
        
        let secondStageSectionCells = [CellMainTable(type: .stage(unit: nil),
                                                     label: "number_engines_rocket".localized,
                                                     value: String(rocket.secondStage.engines)),
                                       CellMainTable(type: .stage(unit: .fuel),
                                                     label: "amount_fuel_rocket".localized,
                                                     value: String(rocket.secondStage.fuelAmountTons))]
        
        let buttonSectionCell = [CellMainTable(type: .button,
                                               label: "launch_button".localized)]
        
        dataTable = [
            SectionMainTable(type: .info, cells: infoSectionCells),
            SectionMainTable(type: .firstStage, cells: firstStageSectionCells),
            SectionMainTable(type: .secondStage, cells: secondStageSectionCells),
            SectionMainTable(type: .launchButton, cells: buttonSectionCell)
        ]
        
        if let burnSecFirst = rocket.firstStage.burnTimeSec {
            dataTable[1].cells.append(CellMainTable(type: .stage(unit: .time),
                                                    label: "combustion_time_rocket".localized,
                                                    value: String(burnSecFirst)))
        }
        if let burnSecSecond = rocket.secondStage.burnTimeSec {
            dataTable[2].cells.append(CellMainTable(type: .stage(unit: .time),
                                                    label: "combustion_time_rocket".localized,
                                                    value: String(burnSecSecond)))
        }
        
        return dataTable
    }
}
