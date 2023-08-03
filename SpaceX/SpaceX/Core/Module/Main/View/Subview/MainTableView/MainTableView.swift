//
//  MainTableView.swift
//  SpaceX
//
//  Created by Alexander Vagin on 08.07.2023.
//

import UIKit

final class MainTableView: UITableView {
    
    // MARK: - Properties
    private var dataTable: [SectionMainTable] = []
    var presenter: MainPresenterProtocol!
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
    func configure(rocket: Rocket) {
        
        let infoSectionCells = [CellMainTable(type: .info,
                                              label: "Первый запуск",
                                              value: rocket.firstFlight.convertToDisplayFormat(from: .fullYearMonthDay)),
                                CellMainTable(type: .info,
                                              label: "Страна",
                                              value: rocket.country.convertCountryToRus()),
                                CellMainTable(type: .info,
                                              label: "Стоимость запуска",
                                              value: rocket.costPerLaunch.roundedDollars)]
        
        let firstStageSectionCells = [CellMainTable(type: .stage(unit: nil),
                                                    label: "Количество двигателей",
                                                    value: String(rocket.firstStage.engines)),
                                      CellMainTable(type: .stage(unit: .fuel),
                                                    label: "Количество топлива",
                                                    value: String(rocket.firstStage.fuelAmountTons))]
        
        let secondStageSectionCells = [CellMainTable(type: .stage(unit: nil),
                                                     label: "Количество двигателей",
                                                     value: String(rocket.secondStage.engines)),
                                       CellMainTable(type: .stage(unit: .fuel),
                                                     label: "Количество топлива",
                                                     value: String(rocket.secondStage.fuelAmountTons))]
        
        let buttonSectionCell = [CellMainTable(type: .button,
                                               label: "Посмотреть запуски")]
        
        dataTable = [
            SectionMainTable(type: .info, cells: infoSectionCells),
            SectionMainTable(type: .firstStage, cells: firstStageSectionCells),
            SectionMainTable(type: .secondStage, cells: secondStageSectionCells),
            SectionMainTable(type: .launchButton, cells: buttonSectionCell)
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
    
    func setup(buttonAction: C.Callback?, presenter: MainPresenterProtocol) {
        self.buttonAction = buttonAction
        self.presenter = presenter
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
            heightAnchor.constraint(equalToConstant: presenter.calculateHeightTable(data: dataTable))
        ]
        NSLayoutConstraint.activate(heightTableConstraint)
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
            return MainTableConstants.cellButtonHeight
        default:
            return MainTableConstants.cellHeight
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch dataTable[section].type {
        case .firstStage, .secondStage:
            return MainTableConstants.sectionHeaderStageHeight
        default:
            return MainTableConstants.sectionHeaderDefaultHeight
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch dataTable[section].type {
        case .info, .firstStage:
            return MainTableConstants.sectionFooterBeginnersStageHeight
        case .secondStage, .launchButton:
            return MainTableConstants.sectionFooterFinalsStageHeight
        }
    }
}
