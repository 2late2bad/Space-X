//
//  MainTableView.swift
//  SpaceX
//
//  Created by Alexander Vagin on 08.07.2023.
//

import UIKit

final class MainTableView: UITableView {
    
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
                                                                   value: "397")])
    ]
    
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

private extension MainTableView {
    
    func initialize() {
        let nibInfo = UINib(nibName: "InfoCell", bundle: nil)
        let nibStage = UINib(nibName: "StageCell", bundle: nil)
        register(nibInfo, forCellReuseIdentifier: InfoCell.identifier)
        register(nibStage, forCellReuseIdentifier: StageCell.identifier)
        register(MainSectionHeader.self, forHeaderFooterViewReuseIdentifier: MainSectionHeader.identifier)
        
        dataSource = self
        delegate = self
    }
    
    func styleTable() {
        backgroundColor = .black
    }
    
    func layoutUI() {
        pinToEdges(of: self)
    }
}

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
            let desired = section.cells[indexPath.row]
            cell.configure(label: desired.label,
                           value: desired.value)
            return cell
        case .firstStage, .secondStage:
            let cell = tableView.dequeueReusableCell(withIdentifier: StageCell.identifier, for: indexPath) as! StageCell
            let desired = section.cells[indexPath.row]
            cell.configure(label: desired.label,
                           value: desired.value,
                           unit: desired.unit)
            return cell
        }
    }
}

extension MainTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let type = testSection[section].type

        switch type {
        case .firstStage, .secondStage:
            if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MainSectionHeader.identifier) as? MainSectionHeader {
                header.titleLabel.text = type.rawValue.uppercased()
                return header
            }
        default:
            return nil
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        40
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch testSection[section].type {
        case .firstStage, .secondStage:
            return 32
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        40
    }
}
