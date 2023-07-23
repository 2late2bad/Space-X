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
    private let indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.color = Colors.activityIndicator.uiColor
        view.startAnimating()
        return view
    }()
    private lazy var emptyLaunchesLabel: UILabel = {
        let view = UILabel()
        view.isHidden = true
        view.font = Fonts.emptyLaunchesLabel.uiFont
        view.textColor = Colors.emptyLaunchesLabel.uiColor
        view.textColor = .white
        view.textAlignment = .center
        view.numberOfLines = 0
        view.text = "Нет информации по запускам данной ракеты :("
        return view
    }()
    
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
}

private extension LaunchVC {
    
    func setup() {
        view.addSubviews(tableView, indicatorView, emptyLaunchesLabel)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LaunchCell.self, forCellReuseIdentifier: LaunchCell.identifier)
    }
    
    func style() {
        view.backgroundColor = Colors.backgroundLaunchVC.uiColor
        tableView.backgroundColor = .clear
        navigationController?.navigationBar.topItem?.title = "Назад"
    }
    
    func layoutUI() {
        updateLayout(with: view.frame.size)
        indicatorView.pinToEdges(of: view)
        emptyLaunchesLabel.pinToEdges(of: view)
        tableView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 40, right: 0)
    }
    
    func updateLayout(with size: CGSize) {
        tableView.frame = CGRect.init(origin: .zero, size: size)
    }
}

// MARK: - Implementation LaunchVCProtocol
extension LaunchVC: LaunchVCProtocol {
    
    func success(with launches: [Launch]) {
        guard !launches.isEmpty else {
            indicatorView.stopAnimating()
            emptyLaunchesLabel.isHidden = false
            return
        }
        
        self.launches = launches
        DispatchQueue.main.async { [weak self] in
            self?.indicatorView.stopAnimating()
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
            fatalError()
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
