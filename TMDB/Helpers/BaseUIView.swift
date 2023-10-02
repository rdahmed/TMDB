//
//  BaseUIView.swift
//  TMDB
//
//  Created by Hessam Mahdiabadi on 10/2/23.
//

import UIKit

class BaseUIView: UIView {

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        initializer()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        initializer()
    }

    open func initializer() {}
}
