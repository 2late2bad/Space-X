//
//  RocketImageView.swift
//  SpaceX
//
//  Created by Alexander Vagin on 18.07.2023.
//

import UIKit

final class RocketImageView: UIView {
    
    // MARK: - Properties
    private lazy var indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.color = Colors.activityIndicator.uiColor
        view.layer.opacity = 0.5
        view.startAnimating()
        view.hidesWhenStopped = true
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.opacity = 0.0
        return imageView
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
            self.imageView.image = image
            self.indicatorView.stopAnimating()
            self.imageView.animateOpacity(duration: 0.7)
        }
    }
    
    func startLoading() {
        DispatchQueue.main.async {
            self.imageView.image = nil
            self.imageView.layer.opacity = 0.0
            self.indicatorView.startAnimating()
        }
    }
}

// MARK: - Private ext
private extension RocketImageView {
    
    func configure() {
        addSubviews(imageView, indicatorView)
        backgroundColor = Colors.backgroundRocketImage.uiColor
    }
    
    func layoutUI() {
        imageView.pinToEdges(of: self, safearea: false)
        indicatorView.pinToEdges(of: self, safearea: false)
    }
}
