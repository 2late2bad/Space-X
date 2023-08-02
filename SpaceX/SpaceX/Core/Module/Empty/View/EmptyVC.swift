//
//  EmptyVC.swift
//  SpaceX
//
//  Created by Alexander Vagin on 07.07.2023.
//

import UIKit

final class EmptyVC: UIViewController {
    
    private let imageView = UIImageView()
    private let mainLabel = CVLabel(font: .errorLabelEmptyScreen, color: .errorLabelEmptyScreen, alignment: .center, lines: 0)
    private let errorLabel = CVLabel(font: .errorMessageEmptyScreen, color: .errorLabelEmptyScreen, alignment: .center, lines: 0)
    private let resetButton = UIButton()
    
    var errorText: String!
    var router: RocketRouterProtocol!
    
    init(errorText: String) {
        super.init(nibName: nil, bundle: nil)
        self.errorText = errorText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configure()
        layout()
    }
}

private extension EmptyVC {
    
    func setup() {
        view.backgroundColor = .brown
        view.addSubviews(imageView, mainLabel, errorLabel, resetButton)
    }
    
    func configure() {
        imageView.image = UIImage(systemName: "exclamationmark.triangle")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        
        mainLabel.text = "Возникла ошибка :("
        errorLabel.text = errorText
        errorLabel.lineBreakMode = .byTruncatingTail
                
        resetButton.backgroundColor = .black
        resetButton.setTitle("Reset", for: .normal)
        resetButton.layer.cornerRadius = 10
        resetButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        resetButton.setTitleColor(.white, for: .normal)
        resetButton.setTitleColor(.brown, for: .application)
        resetButton.addTarget(self, action: #selector(resetButtonPressed), for: .touchUpInside)
    }
    
    func layout() {
        view.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            resetButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            resetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            resetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            resetButton.heightAnchor.constraint(equalToConstant: 40),
            
            
            errorLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 40),
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            errorLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            errorLabel.bottomAnchor.constraint(equalTo: resetButton.topAnchor, constant: -20)
        ])
    }
    
    @objc func resetButtonPressed() {
        router.routeBaseModule()
        dismiss(animated: true)
    }
}
