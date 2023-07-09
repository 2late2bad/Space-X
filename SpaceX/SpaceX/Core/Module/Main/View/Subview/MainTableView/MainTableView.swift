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
        
    private let testSection: [SectionMainTable] = [
        SectionMainTable(type: .info, cells: [CellMainTable(type: .info,
                                                            label: "Первый запуск",
                                                            value: "7 февраля, 2018"),
                                              CellMainTable(type: .info,
                                                            label: "Страна",
                                                            value: "США"),
                                              CellMainTable(type: .info,
                                                            label: "Стоимость запуска",
                                                            value: "$90 млн")]),
        SectionMainTable(type: .firstStage, cells: [CellMainTable(type: .stage(unit: nil),
                                                                  label: "Количество двигателей",
                                                                  value: "27"),
                                                    CellMainTable(type: .stage(unit: .fuel),
                                                                  label: "Количество топлива",
                                                                  value: "308,6"),
                                                    CellMainTable(type: .stage(unit: .time),
                                                                  label: "Время сгорания",
                                                                  value: "593")]),
        SectionMainTable(type: .secondStage, cells: [CellMainTable(type: .stage(unit: nil),
                                                                   label: "Количество двигателей",
                                                                   value: "1"),
                                                     CellMainTable(type: .stage(unit: .fuel),
                                                                   label: "Количество топлива",
                                                                   value: "243,2"),
                                                     CellMainTable(type: .stage(unit: .time),
                                                                   label: "Время сгорания",
                                                                   value: "397")]),
        SectionMainTable(type: .launchButton, cells: [CellMainTable(type: .button,
                                                                    label: "Посмотреть запуски")])
    ]
    
    // MARK: - Init
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: .zero, style: .grouped)
        initialize()
        styleTable()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private methods
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
        backgroundColor = .black
    }
    
    func layoutUI() {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: calculateHeightTable())
        ])
    }
    
    // Adaptive table height calculation
    func calculateHeightTable() -> CGFloat {
        var height: CGFloat = 0
        for section in testSection {
            
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
        testSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        testSection[section].cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = testSection[indexPath.section]
        
        switch section.type {
        case .info:
            let cell = tableView.dequeueReusableCell(withIdentifier: InfoCell.identifier, for: indexPath) as! InfoCell
            let searchCell = section.cells[indexPath.row]
            cell.configure(label: searchCell.label,
                           value: searchCell.value ?? "")
            return cell
        case .firstStage, .secondStage:
            let cell = tableView.dequeueReusableCell(withIdentifier: StageCell.identifier, for: indexPath) as! StageCell
            let searchCell = section.cells[indexPath.row]
            cell.configure(label: searchCell.label,
                           value: searchCell.value ?? "",
                           unit: searchCell.unit)
            return cell
        case .launchButton:
            let cell = tableView.dequeueReusableCell(withIdentifier: ButtonCell.identifier, for: indexPath) as! ButtonCell
            let searchCell = section.cells[indexPath.row]
            cell.configure(label: searchCell.label)
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension MainTableView: UITableViewDelegate {
    
    // Table views
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let type = testSection[section].type

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
    
    // The height of the table elements.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = testSection[indexPath.section]
        switch section.type {
        case .launchButton:
            return LocalConstants.cellButtonHeight
        default:
            return LocalConstants.cellHeight
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch testSection[section].type {
        case .firstStage, .secondStage:
            return LocalConstants.sectionHeaderStageHeight
        default:
            return LocalConstants.sectionHeaderDefaultHeight
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch testSection[section].type {
        case .info, .firstStage:
            return LocalConstants.sectionFooterBeginnersStageHeight
        case .secondStage, .launchButton:
            return LocalConstants.sectionFooterFinalsStageHeight
        }
    }
}
