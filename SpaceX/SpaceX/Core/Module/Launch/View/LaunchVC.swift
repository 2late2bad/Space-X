//
//  LaunchVC.swift
//  SpaceX
//
//  Created by Alexander Vagin on 20.07.2023.
//

import UIKit

protocol LaunchVCProtocol: AnyObject {
    func success(with launches: [Launch])
    func failure(error: NetworkError)
}

final class LaunchVC: UIViewController {
    
    private let tableView: UITableView = .init()
    private var launches: [Launch] = []
    
    // MARK: - Properties
    var router: RocketRouterProtocol!
    var presenter: LaunchPresenterProtocol!
    var idRocket: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layoutUI()
        presenter.getAllRocketLaunches(for: idRocket)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate { context in
            self.updateLayout(with: size)
        }
    }
    
    override var prefersStatusBarHidden: Bool { false }
}

private extension LaunchVC {
    
    func setup() {
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LaunchCell.self, forCellReuseIdentifier: LaunchCell.identifier)
    }
    
    func style() {
        view.backgroundColor = Colors.backgroundLaunchVC.uiColor
        tableView.backgroundColor = .clear
    }
    
    func layoutUI() {
        updateLayout(with: view.frame.size)
        tableView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 40, right: 0)
    }
    
    func updateLayout(with size: CGSize) {
        tableView.frame = CGRect.init(origin: .zero, size: size)
    }
}

// MARK: - Implementation LaunchVCProtocol
extension LaunchVC: LaunchVCProtocol {
    
    func success(with launches: [Launch]) {
        self.launches = launches.sorted { $0.dateUtc > $1.dateUtc }
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func failure(error: NetworkError) {
        //
    }
}

extension LaunchVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        launches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LaunchCell.identifier, for: indexPath) as? LaunchCell else {
            fatalError("Ошибка создания ячейки по идентификатору: \(LaunchCell.identifier)")
        }
        let launch = launches[indexPath.row]
        cell.configure(name: launch.name, date: launch.dateUtc, result: launch.success)
        return cell
    }
}

extension LaunchVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        116
    }
}
