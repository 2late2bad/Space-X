//
//  RocketImageView.swift
//  SpaceX
//
//  Created by Alexander Vagin on 18.07.2023.
//

import UIKit

final class RocketImageView: UIImageView {
    
    // MARK: - Properties
    private lazy var indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.color = Colors.activityIndicator.uiColor
        view.layer.opacity = 0.5
        view.startAnimating()
        view.hidesWhenStopped = true
        return view
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    func setImage(_ image: UIImage?) {
        DispatchQueue.main.async {
            self.indicatorView.stopAnimating()
            self.image = image
        }
    }
    
    func startLoading() {
        DispatchQueue.main.async {
            self.image = nil
            self.indicatorView.startAnimating()
        }
    }
}

// MARK: - Private ext
private extension RocketImageView {
    
    func configure() {
        addSubview(indicatorView)
        contentMode = .scaleToFill
        backgroundColor = Colors.backgroundRocketImage.uiColor
    }
    
    func layoutUI() {
        indicatorView.pinToEdges(of: self, safearea: false)
    }
}
