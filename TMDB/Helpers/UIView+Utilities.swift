//
//  UIView+Utilities.swift
//  TMDB
//
//  Created by Radwa Ahmed on 02/09/2023.
//

import UIKit

extension UIView {
    
    func rounded(_ cornerRadius: CGFloat = 8) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
    
    func circular() {
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
    }
    
    func shadowed(opacity: Float = 0.5, offset: CGSize = .init(width: 2, height: 2)) {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = opacity
    }
    
    func bordered(_ borderColor: UIColor, borderWidth: CGFloat = 2) {
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth =  borderWidth
    }
    
}
