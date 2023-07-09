//
//  UIScrollView+Ext.swift
//  SpaceX
//
//  Created by Alexander Vagin on 09.07.2023.
//

import UIKit

extension UIScrollView {
    
    func scrollToTop(animated: Bool) {
        setContentOffset(CGPoint(x: 0, y: 0), animated: animated)
    }
    
    func scrollToLeft(animated: Bool) {
        setContentOffset(CGPoint(x: -contentInset.left, y: 0), animated: animated)
    }
}
