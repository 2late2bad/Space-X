//
//  UIView+Ext.swift
//  SpaceX
//
//  Created by Alexander Vagin on 07.07.2023.
//

import UIKit

extension UIView {
    
    func pinToEdges(of superview: UIView, safearea: Bool) {
        translatesAutoresizingMaskIntoConstraints = false
        if safearea {
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor),
                leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor),
                trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor),
                bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: superview.topAnchor),
                leadingAnchor.constraint(equalTo: superview.leadingAnchor),
                trailingAnchor.constraint(equalTo: superview.trailingAnchor),
                bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            ])
        }
    }
    
    func addSubviews(_ views: UIView...) { views.forEach { addSubview($0) } }
    
    func animateOpacity(duration: TimeInterval) {
        UIView.animate(withDuration: duration, delay: 0.0) { [weak self] in
            self?.layer.opacity = 1
        }
    }
}
