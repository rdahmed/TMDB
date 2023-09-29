//
//  UICollectionView+CellWidth.swift
//  TMDB
//
//  Created by Radwa Ahmed on 01/09/2023.
//

import UIKit

extension UICollectionView {
    
    func cellWidth(numberOfItemsInRow: Int) -> CGFloat {
        let insets = contentInset.left + contentInset.right
        let interitemSpacing = (collectionViewLayout as? UICollectionViewFlowLayout)?
            .minimumInteritemSpacing ?? .zero
        let totalInteritemSpacing = CGFloat(numberOfItemsInRow - 1) * interitemSpacing
        let availableWidth = frame.width - insets - totalInteritemSpacing
        return floor(availableWidth / CGFloat(numberOfItemsInRow))
    }
    
}
