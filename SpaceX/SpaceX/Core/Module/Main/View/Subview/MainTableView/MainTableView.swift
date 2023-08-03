//
//  MainTableView.swift
//  SpaceX
//
//  Created by Alexander Vagin on 08.07.2023.
//

import UIKit

final class MainTableView: UITableView {
    
    // MARK: - Local constants
    private enum LocalConstants {
        static let cellHeight: CGFloat = 40
        static let cellButtonHeight: CGFloat = 56
        static let sectionHeaderStageHeight: CGFloat = 32
        static let sectionHeaderDefaultHeight: CGFloat = 0
        static let sectionFooterBeginnersStageHeight: CGFloat = 32
        static let sectionFooterFinalsStageHeight: CGFloat = 24
    }
    
    // MARK: - Properties
    private var dataTable: [SectionMainTable] = []
    var buttonAction: C.Callback?
    
    // MARK: - Init
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: .zero, style: .grouped)
        initialize()
        styleTable()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    // TODO: - ???
    func configure(rocket: Rocket) {
        dataTable = [
            SectionMainTable(type: .info, cells: [CellMainTable(type: .info,
                                                                label: "Первый запуск",
                                                                value: rocket.firstFlight.convertToDisplayFormat(from: .fullYearMonthDay)),
                                                  CellMainTable(type: .info,
                                                                label: "Страна",
                                                                value: rocket.country.convertCountryToRus()),
                                                  CellMainTable(type: .info,
                                                                label: "Стоимость запуска",
                                                                value: rocket.costPerLaunch.roundedDollars)]),
            SectionMainTable(type: .firstStage, cells: [CellMainTable(type: .stage(unit: nil),
                                                                      label: "Количество двигателей",
                                                                      value: String(rocket.firstStage.engines)),
                                                        CellMainTable(type: .stage(unit: .fuel),
                                                                      label: "Количество топлива",
                                                                      value: String(rocket.firstStage.fuelAmountTons))]),
            SectionMainTable(type: .secondStage, cells: [CellMainTable(type: .stage(unit: nil),
                                                                       label: "Количество двигателей",
                                                                       value: String(rocket.secondStage.engines)),
                                                         CellMainTable(type: .stage(unit: .fuel),
                                                                       label: "Количество топлива",
                                                                       value: String(rocket.secondStage.fuelAmountTons))]),
            SectionMainTable(type: .launchButton, cells: [CellMainTable(type: .button,
                                                                        label: "Посмотреть запуски")])
        ]
        if let burnSecFirst = rocket.firstStage.burnTimeSec {
            dataTable[1].cells.append(CellMainTable(type: .stage(unit: .time),
                                                    label: "Время сгорания",
                                                    value: String(burnSecFirst)))
        }
        if let burnSecSecond = rocket.secondStage.burnTimeSec {
            dataTable[2].cells.append(CellMainTable(type: .stage(unit: .time),
                                                    label: "Время сгорания",
                                                    value: String(burnSecSecond)))
        }
        
        layoutUI()
        reloadData()
    }
}

// MARK: - Private ext
private extension MainTableView {
    
    func initialize() {
        let nibInfo = UINib(nibName: "InfoCell", bundle: nil)
        let nibStage = UINib(nibName: "StageCell", bundle: nil)
        let nibButton = UINib(nibName: "ButtonCell", bundle: nil)
        register(nibInfo, forCellReuseIdentifier: InfoCell.identifier)
        register(nibStage, forCellReuseIdentifier: StageCell.identifier)
        register(nibButton, forCellReuseIdentifier: ButtonCell.identifier)
        register(MainSectionHeader.self, forHeaderFooterViewReuseIdentifier: MainSectionHeader.identifier)
        
        isScrollEnabled = false
        dataSource = self
        delegate = self
    }
    
    func styleTable() {
        backgroundColor = Colors.backgroundTableView.uiColor
    }
    
    func layoutUI() {
        translatesAutoresizingMaskIntoConstraints = false
        let heightTableConstraint = [
            heightAnchor.constraint(equalToConstant: calculateHeightTable())
        ]
        NSLayoutConstraint.activate(heightTableConstraint)
    }
    
    // Adaptive table height calculation
    func calculateHeightTable() -> CGFloat {
        var height: CGFloat = 0
        for section in dataTable {
            
            switch section.type {
            case .launchButton:
                section.cells.forEach { _ in height += LocalConstants.cellButtonHeight }
            default:
                section.cells.forEach { _ in height += LocalConstants.cellHeight }
            }
            
            switch section.type {
            case .firstStage, .secondStage:
                height += LocalConstants.sectionHeaderStageHeight
            default:
                height += LocalConstants.sectionHeaderDefaultHeight
            }
            
            switch section.type {
            case .info, .firstStage:
                height += LocalConstants.sectionFooterBeginnersStageHeight
            case .secondStage, .launchButton:
                height += LocalConstants.sectionFooterFinalsStageHeight
            }
        }
        return height
    }
}

// MARK: - UITableViewDataSource
extension MainTableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        dataTable.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataTable[section].cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = dataTable[indexPath.section]
        
        switch section.type {
        case .info:
            let cell = tableView.dequeueReusableCell(withIdentifier: InfoCell.identifier, for: indexPath) as! InfoCell
            let searchRow = section.cells[indexPath.row]
            cell.configure(label: searchRow.label,
                           value: searchRow.value)
            return cell
        case .firstStage, .secondStage:
            let cell = tableView.dequeueReusableCell(withIdentifier: StageCell.identifier, for: indexPath) as! StageCell
            let searchRow = section.cells[indexPath.row]
            cell.configure(label: searchRow.label,
                           value: searchRow.value,
                           unit: searchRow.unit)
            return cell
        case .launchButton:
            let cell = tableView.dequeueReusableCell(withIdentifier: ButtonCell.identifier, for: indexPath) as! ButtonCell
            let searchRow = section.cells[indexPath.row]
            cell.configure(label: searchRow.label)
            cell.buttonAction = buttonAction
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension MainTableView: UITableViewDelegate {
    
    // Table views
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let type = dataTable[section].type
        
        switch type {
        case .firstStage, .secondStage:
            if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MainSectionHeader.identifier) as? MainSectionHeader {
                header.titleLabel.text = type.rawValue.uppercased()
                return header
            }
        default: return nil
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? { UIView() }
    
    // The height of the table elements
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = dataTable[indexPath.section]
        switch section.type {
        case .launchButton:
            return LocalConstants.cellButtonHeight
        default:
            return LocalConstants.cellHeight
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch dataTable[section].type {
        case .firstStage, .secondStage:
            return LocalConstants.sectionHeaderStageHeight
        default:
            return LocalConstants.sectionHeaderDefaultHeight
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch dataTable[section].type {
        case .info, .firstStage:
            return LocalConstants.sectionFooterBeginnersStageHeight
        case .secondStage, .launchButton:
            return LocalConstants.sectionFooterFinalsStageHeight
        }
    }
}
