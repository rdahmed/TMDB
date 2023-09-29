//
//  SpinnerCompatible.swift
//  TMDB
//
//  Created by Radwa Ahmed on 04/09/2023.
//

import UIKit

/// A protocol for easy use of `UIActivityIndicators` (Spinners).
protocol SpinnerCompatible: AnyObject {
    
    /// Adds an activity indicator to the the view. Disables the view interaction as long as the spinner is displayed.
    func showSpinner(color: UIColor, dims: Bool, blocks: Bool)
    
    /// Finds the displayed spinner and hides it. Clearing view dimming if was applied.
    func hideSpinner()
    
}

// Default implementation for UIViews
extension SpinnerCompatible where Self: UIView {
    
    /// The spinner to be displayed on your view.
    /// Check `showSpinner(color:dims:)` and `hideSpinner()`
    fileprivate var spinner: UIActivityIndicatorView {
        for subview in subviews {
            if let spinner = subview as? UIActivityIndicatorView {
                return spinner
            }
        }
        
        let spinner = UIActivityIndicatorView(style: .medium)
        if self.frame.width > 40 && self.frame.height > 40 {
            spinner.style = .large
        }
        spinner.hidesWhenStopped = true
        self.layout(spinner, in: self)
        return spinner
    }
    
    // Default implementation
    func showSpinner(color: UIColor = UIColor.accentColor, dims: Bool = false, blocks: Bool = false) {
        self.spinner.backgroundColor = dims ? UIColor.black.withAlphaComponent(0.15) : .clear
        self.spinner.isUserInteractionEnabled = blocks
        self.spinner.color = color
        self.spinner.startAnimating()
    }
    
    // Default implementation
    func hideSpinner() {
        self.isUserInteractionEnabled = true
        self.spinner.stopAnimating()
    }
    
    // MARK: Helper
    private func layout(_ spinner: UIActivityIndicatorView, in view: UIView) {
        view.addSubview(spinner)
        view.bringSubviewToFront(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        spinner.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        spinner.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        spinner.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

// Extending `UIView` to confirm to `SpinnerCompatible` Protocol.
extension UIView: SpinnerCompatible {}
