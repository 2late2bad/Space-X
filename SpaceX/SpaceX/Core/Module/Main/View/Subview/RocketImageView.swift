//
//  RocketImageView.swift
//  SpaceX
//
//  Created by Alexander Vagin on 18.07.2023.
//

import UIKit

final class RocketImageView: UIImageView {
        
    private lazy var indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.color = Colors.activityIndicator.uiColor
        view.layer.opacity = 0.5
        view.startAnimating()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func downloadImage(fromURL url: String) {
        indicatorView.startAnimating()
        NetworkManager.shared.downloadImage(from: url) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.indicatorView.stopAnimating()
                self.image = image
            }
        }
    }
}

private extension RocketImageView {
    
    func configure() {
        addSubview(indicatorView)
        contentMode = .scaleToFill
        backgroundColor = Colors.backgroundRocketImage.uiColor
    }
    
    func layoutUI() {
        indicatorView.pinToEdges(of: self)
    }
}
