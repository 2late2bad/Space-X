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
    
    // MARK: - Properties
    var router: RocketRouterProtocol!
    var presenter: LaunchPresenterProtocol!
    var idRocket: String!
    
    // MARK: - Private properties
    private let tableView: UITableView = .init()
    private var launches: [Launch] = []
    private let indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.color = Colors.activityIndicator.uiColor
        return view
    }()
    private let emptyLaunchesLabel = CVLabel(font: .emptyLaunchesLabel,
                                              color: .emptyLaunchesLabel,
                                              alignment: .center,
                                              lines: 0)
    
    // MARK: - Lifecycle
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

// MARK: - LaunchVCProtocol Impl
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
        let alert = UIAlertController(title: error.message,
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .destructive) { [weak self] action in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
}

// MARK: - Private ext
private extension LaunchVC {
    
    func setup() {
        navigationController?.navigationBar.isHidden = false
        view.addSubviews(tableView, indicatorView, emptyLaunchesLabel)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LaunchCell.self, forCellReuseIdentifier: LaunchCell.identifier)
        
        indicatorView.startAnimating()
        indicatorView.hidesWhenStopped = true
    }
    
    func style() {
        emptyLaunchesLabel.text = "Нет информации по запускам данной ракеты\n :("
        emptyLaunchesLabel.isHidden = true
        
        navigationController?.navigationBar.topItem?.title = "Назад"
        view.backgroundColor = Colors.backgroundLaunchVC.uiColor
        
        tableView.backgroundColor = .clear
    }
    
    func layoutUI() {
        updateLayout(with: view.frame.size)
        indicatorView.pinToEdges(of: view, safearea: false)
        emptyLaunchesLabel.pinToEdges(of: view, safearea: false)
        tableView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 40, right: 0)
    }
    
    func updateLayout(with size: CGSize) {
        tableView.frame = CGRect.init(origin: .zero, size: size)
    }
}

// MARK: - UITableViewDataSource
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

// MARK: - UITableViewDelegate
extension LaunchVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        116
    }
}
