//
//  UIView+Utilities.swift
//  TMDB
//
//  Created by Radwa Ahmed on 02/09/2023.
//

import UIKit

extension UIView {
    
    func rounded(_ cornerRadius: CGFloat = 10, forceMask: Bool = false) {
        layer.cornerRadius = cornerRadius
        if forceMask {
            layer.masksToBounds = true
        }
    }
    
    func circular(_ forceMask: Bool = false) {
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
    }
    
    func shadowed(opacity: Float = 0.08, offset: CGSize = .init(width: 2, height: 2)) {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = 5
        layer.shadowOpacity = opacity
    }
    
    func bordered(_ borderColor: UIColor, borderWidth: CGFloat = 2) {
        layer.borderColor = borderColor.cgColor
        layer.borderWidth =  borderWidth
    }
    
}
